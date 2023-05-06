import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  String? order;
  String? orderId;
  String? totalPrice;
  String? userEmail;
  String? userLocation;
  String? userName;
  String? key;


  TestModel({
    this.order,
    this.orderId,
    this.totalPrice,
    this.userEmail,
    this.userLocation,
    this.userName,
    this.key,
});

  TestModel.fromjson(DocumentSnapshot snapshot){
    order = snapshot["order"];
    orderId = snapshot["orderId"];
    totalPrice = snapshot["totalPrice"];
    userEmail = snapshot["userEmail"];
    userLocation = snapshot["userLocation"];
    userName = snapshot["userName"];
    key = snapshot.id;
  }
}