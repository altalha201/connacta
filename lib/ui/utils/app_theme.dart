import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      primary: ColorConstants.primary,
      brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(color: ColorConstants.primary),
    radioTheme: RadioThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => ColorConstants.primary)),
    checkboxTheme: CheckboxThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => ColorConstants.primary)),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      primary: ColorConstants.primary,
      brightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(color: ColorConstants.primary),
    radioTheme: RadioThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => ColorConstants.primary)),
    checkboxTheme: CheckboxThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => ColorConstants.primary)),
  );
}

/*
ThemeData appTheme(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      primary: ColorConstants.primary,
      brightness: brightness,
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
}*/
