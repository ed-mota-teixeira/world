import 'package:countries/data/lists.dart';
import 'package:countries/models/countries_list.dart';
import 'package:countries/models/country.dart';
import 'package:countries/models/game_page_argument.dart';
import 'package:countries/utils/routing/route_names.dart';
import 'package:countries/views/widgets/capital_name_widget.dart';
import 'package:countries/views/widgets/flag_widget.dart';
import 'package:countries/views/widgets/menu_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  void goToGame(BuildContext context, String route, List<Country> countries,
      Widget gWidget) {
    Navigator.of(context)
        .pushNamed(route, arguments: GamePageArgument(countries, gWidget));
  }

  void _goToEasyFlags(BuildContext context) {
    goToGame(context, kFlagsGameRoute,
        CountriesList().fromCca2(easyCountriesCode), const CorrectFlag());
  }

  void _goToHardFlags(BuildContext context) {
    goToGame(context, kFlagsGameRoute,
        CountriesList().notFromCca2(easyCountriesCode), const CorrectFlag());
  }

  void _goToRandomFlags(BuildContext context) {
    goToGame(
        context, kFlagsGameRoute, CountriesList().list, const CorrectFlag());
  }

  void _goToEasyCapitals(BuildContext context) {
    goToGame(
        context,
        kFlagsGameRoute,
        CountriesList().fromCca2WithCapitals(easyCountriesCode),
        const CapitalName());
  }

  void _goToRandomCapitals(BuildContext context) {
    goToGame(context, kFlagsGameRoute, CountriesList().allWithCapitals(),
        const CapitalName());
  }

  void _goToHardCapitals(BuildContext context) {
    goToGame(
        context,
        kFlagsGameRoute,
        CountriesList().notFromCca2WithCapitals(easyCountriesCode),
        const CapitalName());
  }

  Widget flagsGameOptions(BuildContext context) {
    return MenuOptionItem(
        title: 'FLAGS',
        onEasyPressed: () => _goToEasyFlags(context),
        onHardPressed: () => _goToHardFlags(context),
        onRandomPressed: () => _goToRandomFlags(context));
  }

  Widget capitalsGameOptions(BuildContext context) {
    return MenuOptionItem(
        title: 'CAPITALS',
        onEasyPressed: () => _goToEasyCapitals(context),
        onHardPressed: () => _goToHardCapitals(context),
        onRandomPressed: () => _goToRandomCapitals(context));
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
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 24),
                child: capitalsGameOptions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
