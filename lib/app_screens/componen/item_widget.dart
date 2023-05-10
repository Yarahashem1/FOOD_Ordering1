import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../listing.dart';
import '../../components_login/components.dart';
import 'my_icon.dart';

class Item_widget extends StatefulWidget {
  Item_widget({
    Key? key,
  }) : super(key: key);
  @override
  State<Item_widget> createState() => _Item_widgetState();
}

//FirebaseFirestore db = FirebaseFirestore.instance;
List<dynamic> items = [];
//Map<String, dynamic> data = {};

class _Item_widgetState extends State<Item_widget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}