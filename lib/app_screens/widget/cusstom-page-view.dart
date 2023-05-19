import 'package:flutter/material.dart';

class CusstomPageView extends StatelessWidget {
  const CusstomPageView(
      {Key? key,
      @required this.pageController,
      required Function(int value) onChange})
      : super(key: key);
  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        Column(
          children: [
            //SizedBox(height: 10,),
            Text(
              'Order Online',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 333,
              width: 333,
              decoration: const BoxDecoration(
                //  borderRadius: BorderRadius.all(Radius.circular(150)),
                image: DecorationImage(
                    image: AssetImage('images/page3.jpeg'), fit: BoxFit.fill),
              ),
            )
          ],
        ),
        Column(
          children: [
            // SizedBox(height:MediaQuery.of(context).size.height * .15,),
            Text(
              'Fast Delivery',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 333,
              width: 333,
              decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(150)),
                image: DecorationImage(
                    image: AssetImage('images/page2.jpeg'), fit: BoxFit.fill),
              ),
            )
          ],
        ),
        Column(
          children: [
            // SizedBox(height:MediaQuery.of(context).size.height * .15,),
            Text(
              'Enjoy Your Meal!',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 333,
              width: 333,
              decoration: const BoxDecoration(
                //  borderRadius: BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                    image: AssetImage('images/page1.jpeg'), fit: BoxFit.fill),
              ),
            )
          ],
        ),
      ],
    );
  }
}
