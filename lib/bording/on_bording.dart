


import 'package:flutter/cupertino.dart';
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
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
           
SizedBox(height: 80,),


 
           
             Container(
           height: 450,
           width: double.infinity,
            child:  CusstomPageView(
              pageController: pageController,
            ),
          ),

                SizedBox( height: 20,),

          CusstomIndicator(
              dotsIndex: pageController!.hasClients? pageController?.page : 0,
            ),

            SizedBox(height: 80, ),
          
          Container(
            padding: EdgeInsets.only(left: 26, right: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: pageController!.hasClients? (pageController?.page == 2? false : true ) :true  ,
                    child:InkWell(
                      onTap:(){
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SocialLoginScreen()),
                        );
                      } ,
                      child: const Text('skip',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),),
                    ),
                  ),
                  Cusstom_Button(
                    onTap: () {
                      if(pageController!.page! < 2){
                        pageController?.nextPage(duration: Duration(microseconds: 0),
                         curve: Curves.ease);
                      }else{
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SocialLoginScreen()),
                        );
                      }
                    },
                    text:pageController!.hasClients? (pageController?.page == 2? 'Get Started' : 'Next') : 'Next' ,
                    buttonWidth:pageController!.hasClients? (pageController?.page == 2? 300 : 171): 0 ,
                    buttonHieght:pageController!.hasClients?( pageController?.page == 2? 58 : 48 ): 0 ,
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