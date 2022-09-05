import 'package:countries/models/country.dart';
import 'package:flutter/material.dart';

class CapitalName extends StatelessWidget {
  final Country country;

  const CapitalName({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          country.capital!.first,
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
