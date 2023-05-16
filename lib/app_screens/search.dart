import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app_screens/widget/Food.dart';
import '../components_login/components.dart';

class DataSearch extends StatefulWidget {
  const DataSearch({Key? key}) : super(key: key);

  @override
  State<DataSearch> createState() => _DataSearchState();
}

class _DataSearchState extends State<DataSearch> {
  String searchRoute = '/Search';
  Future getData() async {}
  var searchDelegate = Search(["Snacks", "Sandwiches", "Drinks", "Meals"]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xFFEFEEEE)),
            ),
            child: InkWell(
              onTap: () {
                showSearch(context: context, delegate: searchDelegate);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black45),
                    SizedBox(width: 10),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 2),
        ],
      ),
    );
  }
}

/// itemNotFound page
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
                  // Image.asset(
                  //   'assets/images/search.png',
                  //   width: 100,
                  //   height: 100,
                  // ),
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

/// SearchDelegate
class Search extends SearchDelegate<void> {
  String SearchResult = '/Search';
  final List<String> collections;

  Search(this.collections);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
          }
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "result");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [
        for (var collection in collections)
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(collection).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }

              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

              final List<QueryDocumentSnapshot> suggestions = query.isEmpty
                  ? []
                  : documents.where((document) =>
                  document
                      .get('name')
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();

              return suggestions.isEmpty
                  ? SizedBox.shrink()
                  : Expanded(
                child: ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String name = suggestions[index].get('name');
                    final String image = suggestions[index].get('url');
                    final String category = suggestions[index].get('category');
                    final String price = suggestions[index].get('price');
                    final String description = suggestions[index].get('description');

                    return GestureDetector(
                      onTap: () {
                        log('message');
                        navigateAndFinishRoute2(
                            context,
                            // FoodListingBody(),
                            SearchResult,
                            Food(
                              name: name,
                              category: category,
                              description: description,
                              price: price,
                              url: image,
                            ));
                      },
                      child: ListTile(
                        title: Text(category),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(image),
                        ),
                        subtitle: Text(name),
                      ),
                    );
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}




