import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String imageButton;
  final void Function()? onTap;

  const CustomButton({super.key, required this.imageButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(imageButton, width: 210),
    );
  }
}
