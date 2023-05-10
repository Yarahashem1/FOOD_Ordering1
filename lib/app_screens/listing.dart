import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_screens/widget/Food.dart';
import 'package:provider/provider.dart';
import 'category.dart';
import 'componen/cart.dart';
import 'componen/cart_item.dart';
import 'cart1.dart';
import '../components_login/components.dart';

import 'widget/cusstom-indicator.dart';
import 'widget/cusstom-page-view.dart';

import 'widget/cusstom-indicator.dart';
import 'widget/cusstom-page-view.dart';

class FoodListingBody extends StatefulWidget {
  const FoodListingBody({Key? key}) : super(key: key);

  @override
  State<FoodListingBody> createState() => _FoodListingBodyState();
}

class _FoodListingBodyState extends State<FoodListingBody> {
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Food> food =
        ModalRoute.of(context)!.settings.arguments as Map<String, Food>;
    print("Food is ${food['name']}");
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: Scaffold(
        backgroundColor: Color(0xFFEDEDED),
        appBar: AppBar(
          title: Text(food['food']?.category ?? ''),
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: InkWell(
            child: Icon(Icons.arrow_back_rounded),
            onTap: () {
              navigateAndFinish(
                context,
                Category(),
              );
            },
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: InkWell(
          //       child: Icon(Icons.favorite_outline),
          //       onTap: () {},
          //     ),
          //   )
          // ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 240,
                    width: 200,
                    decoration: BoxDecoration(
                      //  borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(food['food']?.url ?? ''),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${food['food']?.name ?? ''}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${food['food']?.price ?? ''}\$',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //add to cart button
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // margin:const EdgeInsets.only(left: 15),
                        child: const Text(
                          'Descrption',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Container(
                        //   margin:const EdgeInsets.only(left: 15),
                        height: 150,
                        width: 300,
                        child: Text(
                          '${food['food']?.description ?? ''}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(320, 55),
                      ),
                      child: Text(
                        'Add Item to Cart',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Get a reference to the Cart object using Provider
                        Cart cart = Provider.of<Cart>(context, listen: false);
                        // Add a new item to the cart
                        cart.addItem(
                          CartItem(
                            name: food['food']?.name ?? '',
                            imageUrl: food['food']?.url ?? '',
                            // price: double.parse((food['food']?.price ?? '')),
                            price: double.parse(food['food']?.price ?? ''),
                          ),
                        );
                      },
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
