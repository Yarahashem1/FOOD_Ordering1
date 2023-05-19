import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_screens/search.dart';
import 'package:flutter_application_1/app_screens/widget/buttom_bar.dart';
import 'package:flutter_application_1/app_screens/widget/streamBuldier.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
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
                      StreamBuldierWidget(
                        categoryName: 'Meals',
                      ),
                      StreamBuldierWidget(
                        categoryName: 'Drinks',
                      ),
                      StreamBuldierWidget(
                        categoryName: 'Snacks',
                      ),
                      StreamBuldierWidget(
                        categoryName: 'Shandwish',
                      ),

                      // Item_widget(),
                      // Item_widget(),
                    ],
                  ),
                ),
              ),
              ButtomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
