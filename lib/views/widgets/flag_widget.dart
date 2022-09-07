import 'package:countries/controllers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_fade/image_fade.dart';

class CorrectFlag extends ConsumerWidget {
  const CorrectFlag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(countryProvider).correctCountry;

    final h = MediaQuery.of(context).size.height * 0.3;
    final w = MediaQuery.of(context).size.width * 0.4;
    final String assetName = 'assets/flags/${c.cca2!.toLowerCase()}.png';
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
