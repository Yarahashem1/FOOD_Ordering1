import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIcon extends StatefulWidget {
  const MyIcon({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.size = 28,
    this.defaultColor = Colors.grey,
    this.clickedColor = Colors.green,
    required Color color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color defaultColor;
  final Color clickedColor;

  @override
  _MyIconState createState() => _MyIconState();
}

class _MyIconState extends State<MyIcon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.defaultColor;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _animation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    setState(() {
      _currentColor = widget.clickedColor;
    });
    _animationController.forward();
  }

  void _handleTapUp(_) {
    setState(() {
      _currentColor = widget.defaultColor;
    });
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() {
      _currentColor = widget.defaultColor;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Icon(
              widget.icon,
              color: _currentColor,
              size: widget.size,
            ),
          );
        },
      ),
    );
  }
}
