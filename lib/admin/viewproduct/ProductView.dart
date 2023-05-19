import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/admin/viewproduct/EditProductPage.dart';

import '../../components_login/components.dart';
import '../adminHome.dart';

class ProductViewPage extends StatefulWidget {
  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  final CollectionReference mealsRef =
      FirebaseFirestore.instance.collection('Meals');
  final CollectionReference allRef =
      FirebaseFirestore.instance.collection('all');
  final CollectionReference snacksRef =
      FirebaseFirestore.instance.collection('Snacks');
  final CollectionReference drinksRef =
      FirebaseFirestore.instance.collection('Drinks');
  final CollectionReference sandwichRef =
      FirebaseFirestore.instance.collection('Shandwish');
  final CollectionReference searchRef =
      FirebaseFirestore.instance.collection('all');

  Widget _buildProductList(
      String title, CollectionReference collectionRef, String category) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 24)),
        Divider(),
        StreamBuilder<QuerySnapshot>(
          stream: collectionRef.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            List<Widget> productList =
                (snapshot.data?.docs ?? []).map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String id = document.id;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  //Show the products exist in every single category
                  leading: Image.network(data['url']),
                  title: Text(data['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        //Edit details of the item
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          navigateAndFinish(
                            context,
                            EditPage(id: id, category: category),
                          );
                        },
                      ),
                      IconButton(
                        //Delete the item
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
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                ),
                              ],
                            ),
                          );

                          if (confirmDelete == true) {
                            await collectionRef.doc(document.id).delete();
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

            return Column(
              children: productList,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: AppBar(
        title: Text('Products'),
        leading: IconButton(
          icon: Icon(
            //Back to home page
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildProductList('Meals', mealsRef, 'Meals'),
              _buildProductList('Snacks', snacksRef, 'Snacks'),
              _buildProductList('Drinks', drinksRef, 'Drinks'),
              _buildProductList('Sandwiches', sandwichRef, 'Shandwish'),
            ],
          ),
        ),
      ),
    );
  }
}
