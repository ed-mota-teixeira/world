import 'dart:math';

import 'package:countries/controllers/country_provider.dart';
import 'package:countries/models/countries_list.dart';
import 'package:countries/views/widgets/capital_name_widget.dart';
import 'package:countries/views/widgets/selection_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CapitalsGamePage extends ConsumerStatefulWidget {
  const CapitalsGamePage({super.key});

  @override
  createState() => _CapitalGamePage();
}

class _CapitalGamePage extends ConsumerState<CapitalsGamePage> {
  @override
  void initState() {
    super.initState();
    CountriesList().list.shuffle(Random(DateTime.now().second));
    ref.read(countryProvider).init();
    ref.read(countryProvider).changeSource(
        ref.read(countryProvider).processSourceWhereCountryCapitalExists());
  }

  @override
  Widget build(BuildContext context) {
    var control = ref.watch(countryProvider);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, title: const Text('CAPITALS')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CapitalName(country: control.correctCountry),
            SelectionPad(
              buttonColor: Colors.indigo,
              buttonHeight: 64,
              buttonWidth: MediaQuery.of(context).size.width * 0.4,
              textColor: Colors.white,
              texts: ref.read(countryProvider).names,
              correctIndex: control.correctNameIndex,
              onCorrectPressed: () {
                // TODO: show congratulations or victory sound
                // debugPrint('Well done!');
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => ref.read(countryProvider.notifier).next());
              },
              onIncorrectPressed: () {
                // TODO: show correct answer or do something useful
                // debugPrint('Incorrect!');
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => ref.read(countryProvider.notifier).next());
              },
            ),
          ],
        ),
      ),
    ));
  }
}
