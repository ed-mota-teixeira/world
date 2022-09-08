import 'package:countries/controllers/country_provider.dart';
import 'package:countries/views/widgets/flag_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectFlag extends ConsumerWidget {
  const CorrectFlag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(countryProvider).correctCountry;

    return FlagImage(flagCountryCode: c.cca2!.toLowerCase());
  }
}
