import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import '../../components_login/components.dart';
import '../componen/fav.dart';
import '../widget/Food.dart';

//make code resuble
class StreamBuldierWidget extends StatefulWidget {
  final String categoryName;

  const StreamBuldierWidget({Key? key, required this.categoryName})
      : super(key: key);

  @override
  _StreamBuldierWidgetState createState() => _StreamBuldierWidgetState();
}

class _StreamBuldierWidgetState extends State<StreamBuldierWidget> {
  List<dynamic> items = [];
  String listingRoute = '/listing_screen';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.categoryName)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          items = snapshot.data!.docs;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              // Build each item here
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateAndFinishRoute(
                          context,
                          widget,
                          listingRoute,
                          Food(
                            name: items[index]['name'],
                            category: items[index]['category'],
                            description: items[index]['description'],
                            price: items[index]['price'],
                            url: items[index]['url'],
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                onError: (exception, stackTrace) => Visibility(
                                  visible: !kIsWeb,
                                  child: CircularProgressIndicator(),
                                ),
                                image: NetworkImage(
                                  items[index]['url'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: kIsWeb, //defult true
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8, top: 7),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          items[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${items[index]['price']}\$',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("favorite")
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("items")
                                  .where("name",
                                      isEqualTo: items[index]['name'])
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Text("");
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: IconButton(
                                      onPressed: () {
                                        snapshot.data.docs.length == 0
                                            ? addToFavourite(index, items)
                                            : deleteFavourite(index, items);
                                      },
                                      icon: snapshot.data.docs.length == 0
                                          ? Icon(
                                              Icons.favorite_outline,
                                              color: Colors.white,
                                              size: 15,
                                            )
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
              ;
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
