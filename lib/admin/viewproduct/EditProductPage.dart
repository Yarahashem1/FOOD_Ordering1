import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/admin/viewproduct/ProductView.dart';

import '../../components_login/components.dart';

class EditPage extends StatefulWidget {
  final String id;
  final String category;

  EditPage({required this.id, required this.category});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _updateData() async {
    String name = _nameController.text.trim();
    String description = _descriptionController.text.trim();
    String url = _urlController.text.trim();
    double price = double.tryParse(_priceController.text.trim()) ?? 0.0;

    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String description = _descriptionController.text;
      String image = _urlController.text;
      String price = _priceController.text;

      await FirebaseFirestore.instance
          .collection(widget.category)
          .doc(widget.id)
          .update(
        {
          'name': name,
          'description': description,
          'url': url,
          'price': price,
        },
      );
      navigateAndFinish(
        context,
        ProductViewPage(),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Product edited successfully!'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection(widget.category)
        .doc(widget.id)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        _nameController.text = documentSnapshot.data()?['name'] ?? '';
        _descriptionController.text =
            documentSnapshot.data()?['description'] ?? '';
        _urlController.text = documentSnapshot.data()?['url'] ?? '';
        _priceController.text =
            documentSnapshot.data()?['price'].toString() ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: AppBar(
        title: Text('Edit Item'),
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
                controller: _urlController,
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
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      navigateAndFinish(
                        context,
                        ProductViewPage(),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: _updateData,
                    child: Text('UPDATE ITEM'),
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
