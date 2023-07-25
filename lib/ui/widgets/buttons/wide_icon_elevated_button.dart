import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class WideIconElevatedButton extends StatelessWidget {
  const WideIconElevatedButton({
    super.key,
    required this.icon,
    required this.labelText,
    required this.onPressed,
    this.height = 50,
    this.backgroundColor = ColorConstants.primary,
    this.foregroundColor = ColorConstants.white,
    this.borderRadius = 10,
  });

  final Widget icon;
  final String labelText;
  final VoidCallback onPressed;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(labelText),
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: foregroundColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            )),
      ),
    );
  }
}
