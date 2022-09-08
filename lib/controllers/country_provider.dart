import 'package:countries/controllers/process_countries_game_control.dart';
import 'package:countries/controllers/process_regions_game_control.dart';
import 'package:countries/models/countries_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryProvider =
    StateNotifierProvider<FlagsController, CountriesGameProcessControl>((ref) {
  return FlagsController();
});

final regionProvider =
    StateNotifierProvider<RegionsController, RegionsGameProcessControl>((ref) {
  return RegionsController();
});

class FlagsController extends StateNotifier<CountriesGameProcessControl> {
  FlagsController()
      : super(CountriesGameProcessControl(3)..init(CountriesList().list));

  void next() {
    state.next();
    var f = state.copy();
    state = f;
  }

  void clear() {
    state.init(state.source);
  }
}

class RegionsController extends StateNotifier<RegionsGameProcessControl> {
  RegionsController()
      : super(RegionsGameProcessControl(0)..init(CountriesList().list));

  void next() {
    state.next();
    var f = state.copy();
    state = f;
  }

  void clear() {
    state.init(state.source);
  }
}
