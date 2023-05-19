import 'package:flutter/material.dart';
import '../app_screens/widget/cusstom-indicator.dart';
import '../app_screens/widget/cusstom-page-view.dart';
import '../app_screens/widget/cusstom_button.dart';
import '../login/login.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController? pageController = PageController(initialPage: 0);
  int? curruntPage = 0;

  setCurrentPage(int value) {
    this.curruntPage = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              height: 450,
              width: double.infinity,
              child: CusstomPageView(
                pageController: pageController,
                onChange: setCurrentPage,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CusstomIndicator(
              dotsIndex: double.tryParse(curruntPage.toString()),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              padding: const EdgeInsets.only(left: 26, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: curruntPage == 2 ? false : true,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SocialLoginScreen()),
                        );
                      },
                      child: const Text(
                        'skip',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Cusstom_Button(
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    text: curruntPage == 2 ? 'Get Started' : 'Next',
                    buttonWidth: curruntPage == 2 ? 350 : 171,
                    buttonHieght: curruntPage == 2 ? 58 : 48,
                    onTap: () {
                      if (curruntPage == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SocialLoginScreen()),
                        );
                      } else {
                        pageController?.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.ease);
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
