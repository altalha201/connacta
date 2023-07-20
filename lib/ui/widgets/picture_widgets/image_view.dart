import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.network(image);
  }
}
