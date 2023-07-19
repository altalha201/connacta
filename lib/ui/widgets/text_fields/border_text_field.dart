import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class BorderTextField extends StatelessWidget {
  const BorderTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.validator,
    this.keyboardType,
    this.onTap,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      validator: validator,
      keyboardType: keyboardType,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorConstants.gray),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: ColorConstants.gray,
          ),
        ),
      ),
    );
  }
}
