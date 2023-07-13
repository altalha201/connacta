import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.height,
    this.backgroundColor,
    this.radius,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;
  final double? height;
  final double? radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
