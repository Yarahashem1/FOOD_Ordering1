import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'componen/cart.dart';
import 'componen/cart_item.dart';
import 'componen/my_icon.dart';
class CartPage extends StatelessWidget {
  const CartPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart Page')),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Container(
                height: 80,
                color: Color.fromARGB(255, 215, 242, 199),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(right: 20),
                      child: MyIcon(
                        icon: Icons.shopping_cart_outlined,
                        size: 35,
                        color: Color.fromARGB(255, 35, 85, 36),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shopping Cart",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 35, 85, 36)),
                        ),
                        Text(
                          "Verify your quantity and click check",
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: Color.fromARGB(173, 35, 85, 36)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      leading: Image.network(item.imageUrl),
                      title: Text(item.name),
                      subtitle: Text('${item.quantity} x \$${item.price}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              // Increase the quantity of the item in the cart
                              cart.addItem(CartItem(
                                  name: item.name,
                                  price: item.price,
                                  imageUrl: item.imageUrl,
                                  quantity: 1));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              // Remove the item from the cart
                              cart.removeItem(item);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: \$${cart.getTotal().toStringAsFixed(2)}'),
                    ElevatedButton(
                      onPressed: () async {
                        String userId = FirebaseAuth.instance.currentUser!.uid;
                        DocumentSnapshot userSnapshot = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .doc(userId)
                            .get();

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

                        // Generate a unique order ID using a Timestamp
                        Timestamp timestamp = Timestamp.now();
                        String orderId =
                            'Order-${timestamp.seconds}-${timestamp.nanoseconds}';

                        Map<String, dynamic> orderData = {
                          'orderId': orderId, // Add orderId field
                          'order': orderDetails,
                          'totalPrice': cart.getTotal().toStringAsFixed(2),
                          'userName': userName,
                          'userLocation': userLocation,
                          'userEmail': userEmail,
                        };

                        try {
                          await cartCollection.add(orderData);
                          print('Order added to Firestore');
                          cart.clearCart();
                        } catch (error) {
                          print('Failed to add order: $error');
                        }
                      },
                      child: Text('Order Now'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}