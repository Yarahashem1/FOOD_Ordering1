import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/viewproduct/ProductView.dart';
import 'package:flutter_application_1/admin/user_profile/user.dart';
import '../app_screens/componen/elevated.dart';
import '../components_login/components.dart';
import 'cubitAddFood/addFood.dart';
import 'user_profile/adminProfile.dart';
import 'vieworder/view_order.dart';

class adminHome extends StatefulWidget {
  const adminHome({super.key});

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Admain Panal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: null,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: ListView(
            children: [
              MyElevatedButton(
                text: 'Profile',
                onPressed: () {
                  navigateAndFinish(
                    context,
                    Profile(),
                  );
                },
              ),
              MyElevatedButton(
                  keyy: ValueKey('but'),
                text: 'Add Products',
                onPressed: () {
                  navigateTo(context, AddFood());
                },
              ),
              MyElevatedButton(
                text: 'View Products',
                onPressed: () {
                  navigateAndFinish(
                    context,
                    ProductViewPage(),
                  );
                },
              ),
              MyElevatedButton(
                text: 'View Orders',
                onPressed: () {
                  navigateAndFinish(
                    context,
                    ViewOrder(),
                  );
                },
              ),
              MyElevatedButton(
                text: 'Users Profile',
                onPressed: () {
                  navigateAndFinish(
                    context,
                    UserProfiles(),
                  );
                },
              ),
              MyElevatedButton(
                text: 'Log out',
                onPressed: () {
                  _showLogoutConfirmDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
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
                  fontWeight: FontWeight.w600,
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
}
