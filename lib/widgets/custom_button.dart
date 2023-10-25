import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function() onPressed;
  const CustomButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
    );
  }
}
