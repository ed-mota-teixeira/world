import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class FlagImage extends StatelessWidget {
  final String flagCountryCode;
  const FlagImage({super.key, required this.flagCountryCode});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.3;
    final w = MediaQuery.of(context).size.width * 0.4;
    final String assetName =
        'assets/flags/${flagCountryCode.toLowerCase()}.png';
    return LimitedBox(
      maxHeight: h,
      maxWidth: w,
      child: ImageFade(
        fit: BoxFit.contain,
        image: AssetImage(assetName),
        width: w,
        height: h,
      ),
    );
  }
}
