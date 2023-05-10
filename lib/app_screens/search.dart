import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class itemNotFound extends StatelessWidget {
  const itemNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.fromLTRB(40, 16, 24, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  Image.asset(
                    'images/search.jpeg',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 33),
                  Text(
                    'Item not found',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Try searching the item with\n a different keyword.',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Searchdel extends SearchDelegate<String> {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("all");

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // icon leading
    return IconButton(
      onPressed: () {
        close(context, "result");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFirestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          if (snapshot.data!.docs
              .where((QueryDocumentSnapshot<Object?> element) => element['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .isEmpty) {
            return itemNotFound();
          } else {
            // fetch data here
            print(snapshot.data);
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['name']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  final String name = data.get('name');
                  final String image = data.get('image');
                  final String title = data.get('category');

                  return ListTile(
                    onTap: () {
                      // amany
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => amanyScreen(data : data)));
                    },
                    title: Text(title),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(image),
                    ),
                    subtitle: Text(name),
                  );
                }).toList()
              ],
            );
          }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone search for something
    return Center();
  }
}
