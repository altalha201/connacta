import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class UnderlineTextField extends StatelessWidget {
  const UnderlineTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.suffix,
    this.keyboardType,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorConstants.gray),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: ColorConstants.gray,
          ),
        ),
        suffixIcon: suffix,
      ),
    );
  }
}
