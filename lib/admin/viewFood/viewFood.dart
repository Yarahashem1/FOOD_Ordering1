import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components_login/components.dart';
import '../adminHome.dart';
import 'EditFood.dart';


class Product {
 String id;
  final String name;
  final String description;
  final String image;
  final String price;
  
  Product(this.id, this.name, this.description, this.image, this.price);
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Stream<QuerySnapshot> _productStream;

  @override
  void initState() {
    super.initState();
    _productStream = FirebaseFirestore.instance.collection('all').snapshots();
  }

  void _deleteProduct(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm"),
        content: Text("Are you sure you want to delete this product?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL"),
          ),
          TextButton(
            onPressed: () async {
              CollectionReference productsRef =
                  FirebaseFirestore.instance.collection('all');
              await productsRef.doc(product.id).delete();
              Navigator.of(context).pop();
            },
            child: Text(
              "DELETE",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<String, dynamic>;
              final product = Product(
                document.id,
                data['name'],
                data['description'],
                data['url'],
                data['price'],
              );

              return ListTile(
                leading: Image.network(product.image),
                title: Text(product.name),
                subtitle: Text(product.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Ink(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () {
                          print("Edit button pressed");
                          navigateAndFinish(
                      context,
                      EditProductPage(product: product)
                    );
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteProduct(context, product),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
