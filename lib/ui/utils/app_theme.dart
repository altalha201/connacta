import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

ThemeData appTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      primary: ColorConstants.primary,
      brightness: Brightness.light
    ),
    iconTheme: const IconThemeData(
      color: ColorConstants.primary
    ),
    radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => ColorConstants.primary)
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => ColorConstants.primary)
    ),
  );
}