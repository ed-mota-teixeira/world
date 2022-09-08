import 'package:countries/controllers/country_provider.dart';
import 'package:countries/views/widgets/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CapitalName extends ConsumerWidget {
  const CapitalName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(countryProvider).correctCountry;

    return NameWidget(text: c.capital!.first);
  }
}
