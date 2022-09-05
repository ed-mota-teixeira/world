import 'package:countries/models/country.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class Flag extends StatelessWidget {
  final Country country;
  final double? width;
  final double? height;

  const Flag({super.key, required this.country, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/flags/${country.cca2!.toLowerCase()}.png';
    return ImageFade(
      fit: BoxFit.contain,
      image: AssetImage(assetName),
      width: width,
      height: height,
    );
  }
}
