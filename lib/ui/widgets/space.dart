import 'package:flutter/material.dart';

class Space {

  static Widget horizontal({required double size}) => SizedBox(
        width: size,
      );

  static Widget vertical({required double size}) => SizedBox(
        height: size,
      );
}
