import 'package:countries/controllers/app_preferences.dart';
import 'package:countries/controllers/region_provider.dart';
import 'package:countries/controllers/sound.dart';
import 'package:countries/data/lists.dart';
import 'package:countries/models/countries_list.dart';
import 'package:countries/models/country.dart';
import 'package:countries/models/game_page_argument.dart';
import 'package:countries/utils/routing/route_names.dart';
import 'package:countries/views/widgets/capital_name_widget.dart';
import 'package:countries/views/widgets/correct_flag_with_name_widget.dart';
import 'package:countries/views/widgets/flag_widget.dart';
import 'package:countries/views/widgets/menu_option_item.dart';
import 'package:countries/views/widgets/my_animated_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  final titleFlags = 'FLAGS';
  final titleCapitals = 'CAPITALS';
  final titleRegions = 'REGIONS';

  void goToGame(BuildContext context, String route, List<Country> countries,
      Widget gWidget, String title,
      {int extra = 0}) {
    Navigator.of(context).pushNamed(route,
        arguments:
            GamePageArgument(countries, gWidget, title: title, extra: extra));
  }

  void _goToEasyFlags(BuildContext context) {
    goToGame(
        context,
        kFlagsGameRoute,
        CountriesList().fromCca2(easyCountriesCode),
        const CorrectFlag(),
        titleFlags);
  }

  void _goToHardFlags(BuildContext context) {
    goToGame(
        context,
        kFlagsGameRoute,
        CountriesList().notFromCca2(easyCountriesCode),
        const CorrectFlag(),
        titleFlags);
  }

  void _goToRandomFlags(BuildContext context) {
    goToGame(context, kFlagsGameRoute, CountriesList().list,
        const CorrectFlag(), titleFlags);
  }

  void _goToEasyCapitals(BuildContext context) {
    goToGame(
        context,
        kFlagsGameRoute,
        CountriesList().fromCca2WithCapitals(easyCountriesCode),
        const CapitalName(),
        titleCapitals);
  }

  void _goToRandomCapitals(BuildContext context) {
    goToGame(context, kFlagsGameRoute, CountriesList().allWithCapitals(),
        const CapitalName(), titleCapitals);
  }

  void _goToHardCapitals(BuildContext context) {
    goToGame(
        context,
        kFlagsGameRoute,
        CountriesList().notFromCca2WithCapitals(easyCountriesCode),
        const CapitalName(),
        titleCapitals);
  }

  void _goToLearnFlags(BuildContext context) {
    Navigator.of(context).pushNamed(kLearnFlagsRoute);
  }

  void _goToRegions(BuildContext context) {
    goToGame(context, kRegionsGameRoute, CountriesList().list,
        const CorrectFlagWithName(), titleRegions);
  }

  void _goToSubregions(BuildContext context) {
    goToGame(context, kRegionsGameRoute, CountriesList().list,
        const CorrectFlagWithName(), titleRegions,
        extra: 1);
  }

  Widget flagsGameOptions(BuildContext context) {
    return MenuOptionItem(
        title: titleFlags,
        onEasyPressed: () => _goToEasyFlags(context),
        onHardPressed: () => _goToHardFlags(context),
        onRandomPressed: () => _goToRandomFlags(context),
        onLearnPressed: () => _goToLearnFlags(context));
  }

  Widget capitalsGameOptions(BuildContext context) {
    return MenuOptionItem(
        title: titleCapitals,
        onEasyPressed: () => _goToEasyCapitals(context),
        onHardPressed: () => _goToHardCapitals(context),
        onRandomPressed: () => _goToRandomCapitals(context));
  }

  Widget regionsGameOptions(BuildContext context, WidgetRef ref) {
    return MenuOptionItem(
        title: titleRegions,
        onEasyPressed: () {
          ref.read(regionProvider).processType = 0;
          _goToRegions(context);
        },
        onHardPressed: () {
          ref.read(regionProvider).processType = 1;
          _goToSubregions(context);
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haveSound = ref.watch(haveSoundProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WORLD QUIZ'),
          centerTitle: true,
          actions: [
            MyAnimatedIcons(
              iconData1: haveSound ? Icons.music_note : Icons.music_off,
              iconData2: !haveSound ? Icons.music_off : Icons.music_note,
              onPressed: () {
                Sound().isEnabled = !Sound().isEnabled;
                ref
                    .read(soundProvider.notifier)
                    .update((_) => Sound().isEnabled);
                AppPreferences().save(Sound().isEnabled);
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
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
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 24),
                  child: regionsGameOptions(context, ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
