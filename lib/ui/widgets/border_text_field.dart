import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class BorderTextField extends StatelessWidget {
  const BorderTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText,
    this.readOnly,
    this.maxLines,
    this.validator,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? readOnly;
  final int? maxLines;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
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
