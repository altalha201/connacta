import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

ThemeData appTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      primary: ColorConstants.primary,
    ),
  );
}