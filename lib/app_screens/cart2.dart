import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app_screens/category.dart';
import 'package:flutter_application_1/app_screens/cart1.dart';
import 'package:provider/provider.dart';
import '../components_login/components.dart';
import 'componen/cart.dart';

class ConfirmInformationPage extends StatefulWidget {
  @override
  _ConfirmInformationPageState createState() => _ConfirmInformationPageState();
}

class _ConfirmInformationPageState extends State<ConfirmInformationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _address;
  String? _phone;
  bool isOrderButtonEnabled = true;
  bool isOrderInProgress = false;
  bool isDownloadVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (userDoc.exists) {
      setState(() {
        _address = userDoc.data()!['location'];
      });
    }
  }

  Widget _buildAddressField() {
    if (_address == null) {
      return CircularProgressIndicator();
    } else {
      return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(150, 255, 255, 255),
          icon: Icon(Icons.location_pin),
          hintText: 'Confirm your Address',
          helperText: 'Address',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your address';
          }
          return null;
        },
        initialValue: _address,
        onSaved: (value) {
          _address = value!;
        },
      );
    }
  }

  void _updateLocation() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'location': _address,
    });
  }

void _placeOrder(BuildContext context, Cart cart) async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    _updateLocation();
  }

  if (_phone != null &&
      _address != null &&
      _phone!.isNotEmpty &&
      _address!.isNotEmpty) {
    setState(() {
      isOrderInProgress = true;
      isDownloadVisible = true;
    });

    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('Cart');
    Map<String, dynamic> userData =
        userSnapshot.data() as Map<String, dynamic>;
    String userName = userData['name'];
    String userLocation = userData['location'];
    String userEmail = userData['email'];

    String orderDetails = '';
    for (int i = 0; i < cart.items.length; i++) {
      final item = cart.items[i];
      orderDetails += '${item.name} (${item.quantity}) \n';
    }

    Timestamp timestamp = Timestamp.now();
    String orderId = 'Order-${timestamp.seconds}-${timestamp.nanoseconds}';
    String? phone = _phone;

    Map<String, dynamic> orderData = {
      'orderId': orderId,
      'order': orderDetails,
      'totalPrice': cart.getTotal().toStringAsFixed(2),
      'userName': userName,
      'userLocation': userLocation,
      'userEmail': userEmail,
      'userPhone': phone,
    };

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await cartCollection.add(orderData);
        print('Order added to Firestore');
        cart.clearCart();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Column(
                children: [
                  Center(
                    child: Text(
                      'Thank you',
                      style: TextStyle(letterSpacing: 1),
                    ),
                  ),
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/128/3502/3502601.png",
                  ),
                ],
              ),
              content: Text(
                'Your order has been done Successfully! Thank you for using the app.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    navigateAndFinish(
                      context,
                      Category(),
                    );
                  },
                  child: Center(
                    child: Text('Back to Home'),
                  ),
                ),
              ],
            );
          },
        );
        setState(() {
          isOrderButtonEnabled = false;
        });
      } else {
        throw Exception('No internet connection');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:Center(child:
            Container(
              width: 100,height: 100,
              decoration: const BoxDecoration(
                //  borderRadius: BorderRadius.all(Radius.circular(150)),
                image: DecorationImage(
                    image: AssetImage('images/11.png'), fit: BoxFit.fill),
              ),
            )
           ) ,
            content: Text('Failed to add order , pls check out your connection !' ,),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isOrderInProgress = false;
        isDownloadVisible = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: AppBar(
        title: Text('Confirm Your Information'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            navigateAndFinish(
              context,
              CartPage(),
            );
          },
        ),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.green,
                    size: 80.0,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            _buildAddressField(),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(150, 255, 255, 255),
                                hintText: 'Enter your phone number',
                                icon: Icon(Icons.phone_android),
                                helperText: 'Phone Number',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _phone = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: isDownloadVisible
                            ? CircularProgressIndicator()
                            : Container(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    shadowColor: Colors.greenAccent,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    minimumSize: Size(360, 60),
                                  ),
                                  onPressed: isOrderButtonEnabled
                                      ? () => _placeOrder(context , cart)
                                      : null,
                                  child: Text(
                                    'Order Now',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
