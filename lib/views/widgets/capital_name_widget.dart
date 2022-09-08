import 'package:countries/controllers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CapitalName extends ConsumerWidget {
  const CapitalName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(countryProvider).correctCountry;

    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          c.capital!.first,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline4!.fontSize,
              color: Colors.white),
        ),
      ),
    );
  }
}
