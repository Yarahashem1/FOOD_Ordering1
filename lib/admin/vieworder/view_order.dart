import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/admin/vieworder/view_model.dart';

import '../../components_login/components.dart';
import '../adminHome.dart';

class ViewOrder extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<ViewOrder> {
  final stor = FirebaseFirestore.instance;
  List<TestModel> data = [];

  Future<List<TestModel>> get() async {
    final model = await stor.collection("Cart").get();
    data = model.docs.map((e) => TestModel.fromjson(e)).toList();
    print(data.length);
    return data;
  }

  @override
  void initState() {
    super.initState();
    get().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int orderNumber = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Order'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 25),
          onPressed: () {
            navigateAndFinish(
              context,
              adminHome(),
            );
          },
        ),
      ),
      body: FutureBuilder<List<TestModel>>(
        future: get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.only(
                top: 15, left: 10, right: 10, bottom: 10),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[400],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Order Num : ${index + 1}'),
                            SizedBox(
                              width: 210,
                            ),
                            GestureDetector(
                              onTap: () async {
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
                                  await stor.collection('Cart').doc(data[index].key).delete();
                                  setState(() {
                                    data.removeAt(index);
                                  });
                                }
                              },
                              child: Icon(
                                Icons.clear,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'The customer name : ${snapshot.data![index]
                                    .userName}'),
                            const Divider(
                              indent: 2,
                              endIndent: 2,
                            ),
                            Text(
                                'The customer email : ${snapshot.data![index]
                                    .userEmail}'),
                            const Divider(
                              indent: 2,
                              endIndent: 2,
                            ),
                            Text(
                                'The customer address : ${snapshot
                                    .data![index].userLocation}'),
                            const Divider(
                              indent: 2,
                              endIndent: 2,
                            ),
                            Text(
                                'The Total Price : ${snapshot.data![index]
                                    .totalPrice}'),
                            const Divider(
                              indent: 2,
                              endIndent: 2,
                            ),
                            Text(
                                'The customer Phone : ${snapshot.data![index]
                                    .userPhone}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}