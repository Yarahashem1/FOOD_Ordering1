import 'package:flutter/material.dart';

import '../admin/adminHome.dart';
import '../amal/amal.dart';
import '../components_login/components.dart';
import '../login/login.dart';

void main() {
  runApp(const MyProfile());
}

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFEDEDED),
        // extendBodyBehindAppBar: true,
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
            color: Colors.black,
          ),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 25),
          onPressed: () {
            navigateAndFinish(
              context,
              adminHome(),
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

        body: Padding(
          padding: const EdgeInsets.only(left: 25, top: 0),
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
                      image: AssetImage('images/pr.jpeg'), fit: BoxFit.cover),
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
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Your Name :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ahmed mohammed',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Your Email :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'ahmad@gmail.com',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Location :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'No 15 street - Gaza ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}