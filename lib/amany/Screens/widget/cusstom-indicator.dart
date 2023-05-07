import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CusstomIndicator extends StatelessWidget {
  const CusstomIndicator({Key? key, @required this.dotsIndex})
      : super(key: key);
  final double? dotsIndex;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      decorator: DotsDecorator(
        activeColor: Colors.green,
      ),
      dotsCount: 3,
      position: dotsIndex!.toInt(),
    );
  }
}
