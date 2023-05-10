import 'package:flutter/material.dart';


class Cusstom_Button extends StatelessWidget {
   Cusstom_Button({Key? key,this.text, this.buttonWidth, this.buttonHieght, this.onTap,
    @required backgroundColor, @required textColor})
    : super(key: key);
  final String? text;
  final double? buttonWidth;
  final double? buttonHieght;
  final VoidCallback? onTap;
   // Color? backgroundColor; //= Color(0XFF2B2E4A);
 //Color? textColor; //= Color(0XFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: buttonWidth!,
        height: buttonHieght!,
        decoration: BoxDecoration(
            color:Colors.green,
            borderRadius: BorderRadius.circular(30),
        ),
        
        child: Center(
          child: Text( text!,
            style: TextStyle(
              color:  Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            ),
        ),),
    );
  }
}