import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatefulWidget {
  final String text;
  final Function onPressed;
   dynamic keyy;

  MyElevatedButton({required this.text, required this.onPressed,this.keyy});

  @override
  _MyElevatedButtonState createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          key:widget.keyy,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                _isSelected ? Colors.green : Colors.green),
          ),
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected;
            });
            widget.onPressed();
          },
          child: Text(
            widget.text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}