import 'package:flutter_application_1/amal/amal.dart';
import 'package:flutter_application_1/amal/shimaa2.dart';
import 'package:flutter/material.dart';
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
          )),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Container(
                height: 80,
                color: Color.fromARGB(255, 215, 242, 199),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(right: 20),
                      child: MyIcon(
                        icon: Icons.shopping_cart_outlined,
                        size: 35,
                        color: Color.fromARGB(255, 35, 85, 36),
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
                              color: Color.fromARGB(255, 35, 85, 36)),
                        ),
                        Text(
                          "Verify your quantity and click check",
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(color: Color.fromARGB(173, 35, 85, 36)),
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
                    return ListTile(
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
                              cart.addItem(CartItem(
                                  name: item.name,
                                  price: item.price,
                                  imageUrl: item.imageUrl,
                                  quantity: 1));
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
                    Text('Total: \$${cart.getTotal().toStringAsFixed(2)}'),
                    ElevatedButton(
                      onPressed: () {
                        if ((cart.getTotal()) != 0) {
                          navigateAndFinish(
                            context,
                            ConfirmInformationPage(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "You haven't order yet !"),
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
            ],
          );
        },
      ),
    );
  }
}
