import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/user_profile/user_model.dart';
import 'package:flutter_application_1/admin/user_profile/user_prof.dart';
import '../../components_login/components.dart';
import '../adminHome.dart';

class UserProfiles extends StatefulWidget {
  const UserProfiles({Key? key}) : super(key: key);

  @override
  State<UserProfiles> createState() => _UserProfilesState();
}

class _UserProfilesState extends State<UserProfiles> {
  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) {
    Widget buildUser(UserModel socialuser) => Card(
          child: ListTile(
            leading: const Icon(
              Icons.account_circle_rounded,
              size: 42,
              color: Colors.green,
            ),
            trailing: InkWell(
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.green,
              ),
              onTap: () {
                navigateAndFinish(
                  context,
                  UserProfile(
                    userName: socialuser.userName,
                    userEmail: socialuser.userEmail,
                    userLocation: socialuser.userLocation,
                    userBio: socialuser.userBio,
                  ),
                );
              },
            ),
            title: Text(socialuser.userName,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(
              socialuser.userEmail,
              style: const TextStyle(
                color: Colors.black26,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          ),
        );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            'Users Profile',
            style: TextStyle(
              backgroundColor: Colors.green,
            ),
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
                adminHome(),
              );
            },
          )),
      body: StreamBuilder<List<UserModel>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Somthing went wrong');
            } else if (snapshot.hasData) {
              final users = snapshot.data;
              return Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: users!.map(buildUser).toList(),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
