import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_screens/search.dart';
import 'package:flutter_application_1/app_screens/usersProfile.dart';
import 'package:flutter_application_1/app_screens/widget/Food.dart';

import 'package:flutter_application_1/components_login/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart1.dart';
import 'componen/item_widget.dart';
import 'componen/my_icon.dart';
import 'favorite.dart';


class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String listingRoute = '/listing_screen';
  Future deleteFavourite1(int i) async {
    return await FirebaseFirestore.instance
        .collection('favorite')
        .doc(FirebaseAuth.instance.currentUser!
        .email) // replace with the actual document ID of the user
        .collection('items')
        .where('name',
        isEqualTo: items[i]
        ['name']) // replace with the actual name of the item
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();

        // delete the document reference
      });
    });
  }

  Future addToFavourite(int i) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("favorite");
    return await _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": items[i]['name'],
      "price": items[i]['price'],
      "images": items[i]['url'],
      "uid": items[i]['uid']
    }).then((value) {
      print("Added to favourite");
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    Color? color = Color(0XFF9A9A9D);
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFEDEDED),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Delicious \nfood for you',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w700,
                      fontSize: 33,
                      fontFamily: 'SF Pro Rounded'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DataSearch(),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: const TabBar(
                  indicatorColor: Colors.green,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: 30),
                  tabs: [
                    Tab(
                      text: "Food",
                      height: 35,
                    ),
                    Tab(
                      text: "Drinks",
                      height: 35,
                    ),
                    Tab(
                      text: "Snaks",
                      height: 35,
                    ),
                    Tab(
                      text: "Shandwish",
                      height: 35,
                    )
                  ],
                  isScrollable: true,
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TabBarView(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Meals')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            items = snapshot.data!.docs;
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // Build each item here
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
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
                                        onTap: () async {
                                          print(items[index]['name']);
                                          // navigateAndFinish(
                                          //   context,
                                          //   FoodListingBody(),
                                          // );
                                          navigateAndFinishRoute(
                                              context,
                                              widget,
                                              listingRoute,
                                              Food(
                                                name: items[index]['name'],
                                                category: items[index]
                                                ['category'],
                                                description: items[index]
                                                ['description'],
                                                price: items[index]['price'],
                                                url: items[index]['url'],
                                              ));
                                        },
                                        child: Image.network(
                                          items[index]['url'],
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2, // 20% of available width
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2,
                                          fit: BoxFit
                                              .cover, // 20% of available width
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 8, top: 7),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            items[index]['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                items[index]['price'],
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("favorite")
                                                    .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                    .collection("items")
                                                    .where("name",
                                                    isEqualTo: items[index]
                                                    ['name'])
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.data == null) {
                                                    return Text("");
                                                  }
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        right: 8),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                      Colors.green,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          snapshot.data.docs
                                                              .length ==
                                                              0
                                                              ? addToFavourite(
                                                              index)
                                                              : deleteFavourite1(
                                                              index);
                                                        },
                                                        icon: snapshot.data.docs
                                                            .length ==
                                                            0
                                                            ? Icon(
                                                          Icons
                                                              .favorite_outline,
                                                          color: Colors
                                                              .white,
                                                          size: 15,
                                                        )
                                                            : Icon(
                                                          Icons.favorite,
                                                          color: Colors
                                                              .white,
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
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Drinks')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            items = snapshot.data!.docs;
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // Build each item here
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
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
                                        onTap: () async {
                                          print(items[index]['name']);
                                          // navigateAndFinish(
                                          //   context,
                                          //   FoodListingBody(),
                                          // );
                                          navigateAndFinishRoute(
                                              context,
                                              widget,
                                              listingRoute,
                                              Food(
                                                name: items[index]['name'],
                                                category: items[index]
                                                ['category'],
                                                description: items[index]
                                                ['description'],
                                                price: items[index]['price'],
                                                url: items[index]['url'],
                                              ));
                                        },
                                        child: Image.network(
                                          items[index]['url'],
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2, // 20% of available width
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2, // 20% of available width
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 8, top: 7),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            items[index]['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                items[index]['price'],
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("favorite")
                                                    .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                    .collection("items")
                                                    .where("name",
                                                    isEqualTo: items[index]
                                                    ['name'])
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.data == null) {
                                                    return Text("");
                                                  }
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        right: 8),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                      Colors.green,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          snapshot.data.docs
                                                              .length ==
                                                              0
                                                              ? addToFavourite(
                                                              index)
                                                              : deleteFavourite1(
                                                              index);
                                                        },
                                                        icon: snapshot.data.docs
                                                            .length ==
                                                            0
                                                            ? Icon(
                                                          Icons
                                                              .favorite_outline,
                                                          color: Colors
                                                              .white,
                                                          size: 15,
                                                        )
                                                            : Icon(
                                                          Icons.favorite,
                                                          color: Colors
                                                              .white,
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
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Snacks')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            items = snapshot.data!.docs;
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // Build each item here
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
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
                                        onTap: () async {
                                          print(items[index]['name']);
                                          // navigateAndFinish(
                                          //   context,
                                          //   FoodListingBody(),
                                          // );
                                          navigateAndFinishRoute(
                                              context,
                                              widget,
                                              listingRoute,
                                              Food(
                                                name: items[index]['name'],
                                                category: items[index]
                                                ['category'],
                                                description: items[index]
                                                ['description'],
                                                price: items[index]['price'],
                                                url: items[index]['url'],
                                              ));
                                        },
                                        child: Image.network(
                                          items[index]['url'],
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2, // 20% of available width
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2, // 20% of available width
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 8, top: 7),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            items[index]['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                items[index]['price'],
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("favorite")
                                                    .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                    .collection("items")
                                                    .where("name",
                                                    isEqualTo: items[index]
                                                    ['name'])
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.data == null) {
                                                    return Text("");
                                                  }
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        right: 8),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                      Colors.green,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          snapshot.data.docs
                                                              .length ==
                                                              0
                                                              ? addToFavourite(
                                                              index)
                                                              : deleteFavourite1(
                                                              index);
                                                        },
                                                        icon: snapshot.data.docs
                                                            .length ==
                                                            0
                                                            ? Icon(
                                                          Icons
                                                              .favorite_outline,
                                                          color: Colors
                                                              .white,
                                                          size: 15,
                                                        )
                                                            : Icon(
                                                          Icons.favorite,
                                                          color: Colors
                                                              .white,
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
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Shandwish')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            items = snapshot.data!.docs;
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // Build each item here
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
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
                                        onTap: () async {
                                          print(items[index]['name']);
                                          // navigateAndFinish(
                                          //   context,
                                          //   FoodListingBody(),
                                          // );
                                          navigateAndFinishRoute(
                                              context,
                                              widget,
                                              listingRoute,
                                              Food(
                                                name: items[index]['name'],
                                                category: items[index]
                                                ['category'],
                                                description: items[index]
                                                ['description'],
                                                price: items[index]['price'],
                                                url: items[index]['url'],
                                              ));
                                        },
                                        child: Image.network(
                                          items[index]['url'],
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2, // 20% of available width
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2, // 20% of available width
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(bottom: 8, top: 7),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            items[index]['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                items[index]['price'],
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("favorite")
                                                    .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                    .collection("items")
                                                    .where("name",
                                                    isEqualTo: items[index]
                                                    ['name'])
                                                    .snapshots(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.data == null) {
                                                    return Text("");
                                                  }
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        right: 8),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                      Colors.green,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          snapshot.data.docs
                                                              .length ==
                                                              0
                                                              ? addToFavourite(
                                                              index)
                                                              : deleteFavourite1(
                                                              index);
                                                        },
                                                        icon: snapshot.data.docs
                                                            .length ==
                                                            0
                                                            ? Icon(
                                                          Icons
                                                              .favorite_outline,
                                                          color: Colors
                                                              .white,
                                                          size: 15,
                                                        )
                                                            : Icon(
                                                          Icons.favorite,
                                                          color: Colors
                                                              .white,
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
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),

                      // Item_widget(),
                      // Item_widget(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 25, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: MyIcon(
                        icon: Icons.home_outlined,
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: MyIcon(
                        icon: Icons.favorite_outline,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => favorite()),
                        );
                      },
                    ),
                    InkWell(
                      child: MyIcon(
                        icon: Icons.shopping_cart_outlined,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      },
                    ),
                    InkWell(
                      child: MyIcon(
                        icon: Icons.person_outline,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyProfile()),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}