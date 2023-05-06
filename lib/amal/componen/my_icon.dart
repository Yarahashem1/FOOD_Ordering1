import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  const MyIcon({
    Key? key,
    required this.icon,
    this.size = 24,
    this.color = Colors.grey,
  }) : super(key: key);
  final IconData icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}