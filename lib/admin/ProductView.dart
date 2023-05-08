import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/admin/EditProductPage.dart';

import '../components_login/components.dart';
import 'adminHome.dart';

class ProductViewPage extends StatefulWidget {
  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  CollectionReference mealsRef = FirebaseFirestore.instance.collection('Meals');
  CollectionReference allRef = FirebaseFirestore.instance.collection('all');
  CollectionReference snacksRef =
      FirebaseFirestore.instance.collection('Snacks');
  CollectionReference drinksRef =
      FirebaseFirestore.instance.collection('Drinks');
  CollectionReference sandwichRef =
      FirebaseFirestore.instance.collection('Shandwish');
  CollectionReference searchRef = FirebaseFirestore.instance.collection('all');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Products'),
          leading: IconButton(
            icon: Icon(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: mealsRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                List<Widget> mealList = (snapshot.data?.docs ?? [])
                    .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String id = document.id;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(data['url']),
                      title: Text(data['name']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  EditPage(id: id, category: "Meals"),
                                );
                              }),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirm delete'),
                                  content: Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('CANCEL'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      child: Text('DELETE'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmDelete == true) {
                                await mealsRef.doc(document.id).delete();
                                if (await FirebaseFirestore.instance
                                    .collection('all')
                                    .doc('name')
                                    .collection('meals')
                                    .get()
                                    .then((value) => value.docs.isNotEmpty)) {
                                  await allRef.doc(document.id).delete();
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }).toList();

                return Column(children: [
                  Text('Meals', style: TextStyle(fontSize: 24)),
                  Divider(),
                  ...mealList,
                ]);
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: snacksRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                List<Widget> snackList = (snapshot.data?.docs ?? [])
                    .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String id = document.id;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(data['url']),
                      title: Text(data['name']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              navigateAndFinish(
                                context,
                                EditPage(id: id, category: "Snacks"),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirm delete'),
                                  content: Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('CANCEL'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      child: Text('DELETE'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmDelete == true) {
                                await snacksRef.doc(document.id).delete();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }).toList();

                return Column(children: [
                  Text('Snacks', style: TextStyle(fontSize: 24)),
                  Divider(),
                  ...snackList,
                ]);
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: drinksRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                List<Widget> drinkList = (snapshot.data?.docs ?? [])
                    .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String id = document.id;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(data['url']),
                      title: Text(data['name']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              navigateAndFinish(
                                context,
                                EditPage(id: id, category: "Drinks"),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirm delete'),
                                  content: Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('CANCEL'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      child: Text('DELETE'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmDelete == true) {
                                await drinksRef.doc(document.id).delete();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }).toList();

                return Column(children: [
                  Text('Drinks', style: TextStyle(fontSize: 24)),
                  Divider(),
                  ...drinkList,
                ]);
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: sandwichRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                List<Widget> sandwichList = (snapshot.data?.docs ?? [])
                    .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String id = document.id;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(data['url']),
                      title: Text(data['name']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              navigateAndFinish(
                                context,
                                EditPage(id: id, category: "Shandwish"),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirm delete'),
                                  content: Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('CANCEL'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      child: Text('DELETE'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmDelete == true) {
                                await sandwichRef.doc(document.id).delete();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }).toList();

                return Column(children: [
                  Text('Sandwiches', style: TextStyle(fontSize: 24)),
                  Divider(),
                  ...sandwichList,
                ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
