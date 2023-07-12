import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class UnderlineTextField extends StatelessWidget {
  const UnderlineTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText,
    this.readOnly,
    this.validator,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? readOnly;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorConstants.gray),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: ColorConstants.gray,
          ),
        ),
      ),
    );
  }
}
