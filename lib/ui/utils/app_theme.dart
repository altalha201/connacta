import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      primary: ColorConstants.primary,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      color: ColorConstants.white,
      titleTextStyle: TextStyles.appbarTitle.copyWith(
        color: ColorConstants.black,
      ),
      iconTheme: const IconThemeData(
        color: ColorConstants.black,
      ),
    ),
    scaffoldBackgroundColor: ColorConstants.white.withOpacity(0.95),
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
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyles.appbarTitle,
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
