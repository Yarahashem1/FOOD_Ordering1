import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/amal/amal.dart';
import 'package:flutter_application_1/main.dart';

import '../admin/adminHome.dart';
import '../components_login/components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyProfile());
}

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<Map<String, dynamic>> userInfo = [];
  bool _loading = true;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var locationController = TextEditingController();

  void _showLogoutConfirmDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Confirm Logout!'),
          content: Text('Are you sure?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.red,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        );
      },
    );
    if (result ?? false) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

// TODO function get profile
  Future getAccountInfo(String id) async {
    print('the id user is : $id');
    setState(() {
      userInfo = [];
    });
    setState(() {
      _loading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id ?? "123")
        .get()
        .then((value) {
      setState(() {
        userInfo.add(value.data()!);
      });
    }).whenComplete(() {
      setState(() {
        _loading = true;
      });
      setState(() {
        nameController.text = userInfo[0]['name'];
        locationController.text = userInfo[0]['location'];
        emailController.text = userInfo[0]['email'];
      });

      setState(() {
        _loading = false;
      });
    });
    if (userInfo[0].isNotEmpty ||
        userInfo != [] ||
        userInfo[0] != null ||
        userInfo != null) {
      setState(() {
        _loading = false;
      });
    }
  }

// TODO function update account user
  Future updateUserAccount(String id) async {
    print('the id user is : $id');
    setState(() {
      _loading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id ?? "123")
        .update({
      "name": nameController.text,
      "location": locationController.text,
    }).then((value) async {
      await getAccountInfo(id);
    });
  }

  @override
  void initState() {
    getAccountInfo(uIdCustomer!);

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 25),
          onPressed: () {
            navigateAndFinish(
              context,
              Category(),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutConfirmDialog(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 25, top: 0),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //  aliggnment: Alignment.center,
                    children: [
                      // SizedBox(height: 20),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('images/pr.jpeg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(height: 10),

                      Text(
                        'My information',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      // centerTitle: false,
                      SizedBox(height: 20),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: nameController,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Your Name :',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8.0),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 0.8,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Your Email :',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8.0),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 0.8,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: locationController,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Location :',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8.0),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 0.8,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          updateUserAccount(uIdCustomer!);
                        },
                        child: Container(
                          width: 315,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Update',
                              style: const TextStyle(
                                color: Color(0XFFFFFFFF),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
