import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'listing.dart';
import '../components_login/components.dart';

class  favorite extends StatefulWidget {
  const  favorite({Key? key}) : super(key: key);

  @override
  State< favorite> createState() => _favoriteState();
}

List<dynamic> itemss = [];
Future deleteFavourite(int i) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection("favorite");
  return FirebaseFirestore.instance.collection('favorite')
      .doc(FirebaseAuth.instance.currentUser!.email) // replace with the actual document ID of the user
      .collection('items')
      .where('name', isEqualTo:itemss[i]['name'] ) // replace with the actual name of the item
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete(); // delete the document reference
    });
  });
}

class _favoriteState extends State< favorite> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    Color? color = Color(0XFF9A9A9D);
    return DefaultTabController(
          length: 1,
          child: SafeArea(
            child: Scaffold(
              appBar:  AppBar(
                backgroundColor: Colors.green,
                title: Text("Favorite Screen",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                leading: InkWell(
                  child: Icon(Icons.arrow_back_rounded),
                  onTap: () {
                    Navigator.pop(context);

                  },
                ),),

              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TabBarView(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('favorite').doc(FirebaseAuth.instance.currentUser!.email).collection('items')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                itemss = snapshot.data!.docs;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: itemss.length,
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

                                              navigateAndFinish(
                                                context,
                                                FoodListingBody(),
                                              );
                                            },
                                            child: Image.network(
                                              itemss[index]['images'],
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2, // 20% of available width
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.2, // 20% of available width
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          Column(children: [ Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 4, top: 10),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                itemss[index]['name'],
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
                                                      itemss[index]['price'],
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                    SizedBox(width: 30,),

                                                    StreamBuilder(
                                                      stream: FirebaseFirestore.instance.collection("favorite").doc(FirebaseAuth.instance.currentUser!.email)
                                                          .collection("items").where("name",isEqualTo: itemss[index]['name']).snapshots(),
                                                      builder: (BuildContext context, AsyncSnapshot snapshot){
                                                        if(snapshot.data==null){
                                                          return Text("");
                                                        }
                                                        return Padding(
                                                          padding: const EdgeInsets.only(right: 8),
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.green,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                FirebaseFirestore.instance.collection("favorite").doc(FirebaseAuth.instance.currentUser!.email)
                                                                    .collection("items").where("name",isEqualTo: itemss[index]['name']).get().
                                                                then((value) {
                                                                  snapshot.data.docs.length!=0?deleteFavourite(index):print("Already Added");
                                                                } );
                                                              },
                                                              icon: snapshot.data.docs.length==0? Icon(
                                                                Icons.favorite_outline,
                                                                color: Colors.white,
                                                                size: 15,
                                                              ):Icon(
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
                                          ],)  ],
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

                ],
              ),
            ),
          ),
        );
  }
}