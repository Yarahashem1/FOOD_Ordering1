import 'package:flutter_application_1/app_screens/category.dart';
import 'package:flutter_application_1/app_screens/cart2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_screens/widget/buttom_bar.dart';
import 'package:provider/provider.dart';
import '../components_login/components.dart';
import 'componen/cart.dart';
import 'componen/cart_item.dart';
import 'componen/my_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      appBar: AppBar(
        title: Text('Cart Page'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            navigateAndFinish(
              context,
              Category(),
            );
          },
        ),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Color.fromARGB(177, 205, 205, 205),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin:
                    EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                padding: EdgeInsets.only(top: 15 ,bottom: 15 ,left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Color.fromARGB(255, 102, 102, 102),
                        size: 32.0,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shopping Cart",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 102, 102, 102),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Verify your quantity and check all",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(205, 104, 104, 104),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(item.imageUrl),
                        title: Text(item.name),
                        subtitle: Text('${item.quantity} x \$${item.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // Increase the quantity of the item in the cart
                                cart.addItem(
                                  CartItem(
                                    name: item.name,
                                    price: item.price,
                                    imageUrl: item.imageUrl,
                                    quantity: 1,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                // Remove the item from the cart
                                cart.removeItem(item);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Total price
                    Text('Total: \$${cart.getTotal().toStringAsFixed(2)}'),
                    ElevatedButton(
                      onPressed: () {
                        if (cart.getTotal() != 0) {
                          navigateAndFinish(
                            context,
                            ConfirmInformationPage(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("You haven't ordered yet!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text('Finish and Order'),
                    ),
                  ],
                ),
              ),
              ButtomBar(),
            ],
          );
        },
      ),
    );
  }
}
