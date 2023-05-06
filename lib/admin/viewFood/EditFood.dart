import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/viewFood/viewFood.dart';

import '../../components_login/components.dart';



class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({Key, required this.product}) : super(key: Key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _imageController.text = widget.product.image;
    _priceController.text = widget.product.price;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'Image',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
  controller: _priceController,
  decoration: InputDecoration(
    labelText: 'Price',
  ),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter a price';
    }
    
    return null;
  },
),

              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      navigateAndFinish(
                        context,
                        ProductPage(),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: Text('SAVE'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String name = _nameController.text;
                        String description = _descriptionController.text;
                        String image = _imageController.text;
                        String price = _priceController.text;

                        Product editedProduct =
                            Product(widget.product.id, name, description, image, price);
                        editedProduct.id = widget.product.id;
                        _editProduct(editedProduct);

                        navigateAndFinish(
                        context,
                        ProductPage(),
                      );

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Product edited successfully!'),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _editProduct(Product product) {
  CollectionReference products = FirebaseFirestore.instance.collection('all');

  // Update the document in Firestore
  products
      .doc(product.id)
      .update({
        'name': product.name,
        'description': product.description,
        'image': product.image,
        'price': product.price
      })
      .then((value) => print('Product updated'))
      .catchError((error) => print('Failed to update product: $error'));
}