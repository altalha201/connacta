import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.height = 50,
    this.backgroundColor,
    this.radius = 10,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;
  final double height;
  final double radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
