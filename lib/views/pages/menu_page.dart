import 'package:countries/data/lists.dart';
import 'package:countries/models/countries_list.dart';
import 'package:countries/models/game_page_argument.dart';
import 'package:countries/utils/routing/route_names.dart';
import 'package:countries/views/widgets/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  void goToEasyFlags(BuildContext context) {
    Navigator.of(context).pushNamed(kFlagsGameRoute,
        arguments: GamePageArgument(
            CountriesList().fromCca2(easyCountriesCode), const CorrectFlag()));
  }

  void goToHardFlags(BuildContext context) {
    Navigator.of(context).pushNamed(kFlagsGameRoute,
        arguments: GamePageArgument(
            CountriesList().notFromCca2(easyCountriesCode),
            const CorrectFlag()));
  }

  Widget flagsGameOptions(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 48,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.all(12),
              child: Text('FLAGS'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 12, end: 12, bottom: 12),
                  child: OutlinedButton(
                    onPressed: () => goToEasyFlags(context),
                    child: const Text('EASY',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 12, end: 12, bottom: 12),
                  child: OutlinedButton(
                    onPressed: () => goToHardFlags(context),
                    child: const Text('HARD',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WORLD QUIZ'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 24),
                child: flagsGameOptions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
