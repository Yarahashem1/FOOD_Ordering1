import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_screens/category.dart';
import 'package:flutter_application_1/app_screens/widget/buttom_bar.dart';
import 'package:flutter_application_1/main.dart';
import '../cashe.dart';
import '../components_login/components.dart';

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
  late String userId;
  late TextEditingController _nameTextController;
  late TextEditingController _locationTextController;

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
                Navigator.pop(context, false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                    color: Colors.green,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
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
        .doc(id)
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
    await FirebaseFirestore.instance.collection("users").doc(id).update({
      "name": nameController.text,
      "location": locationController.text,
    }).then((value) async {
      await getAccountInfo(id);
    });
  }

  Future<void> getIdSharedRefrance() async {
    uIdAdmin = await CacheHelper.getData(key: 'uIdAdmin') ?? "123";
    uIdCustomer = await CacheHelper.getData(key: 'uIdCustomer') ?? "123";
  }

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _locationTextController = TextEditingController();
    getIdSharedRefrance().then((_) {
      if (uIdCustomer != null) {
        getAccountInfo(uIdCustomer!);
      }
    });
    userInfo = [];
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _locationTextController.dispose();
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
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
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
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //  aliggnment: Alignment.center,
                  children: [
                    // SizedBox(height: 20),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/pr.jpeg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10),

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
                    ElevatedButton(
                      onPressed: () {
                        _performMyProfile();
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
                    Padding(
                      padding: const EdgeInsets.only(top: 255),
                      child: ButtomBar(),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void _performMyProfile() {
    if (_checkData()) {
      updateUserAccount(uIdCustomer!);
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _locationTextController.text.isNotEmpty) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enter required data',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          elevation: 4,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          dismissDirection: DismissDirection.horizontal,
        ),
      );
      return false;
    }
  }
}
