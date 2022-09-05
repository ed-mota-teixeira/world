import 'package:countries/controllers/process_countries_game_control.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryProvider =
    StateNotifierProvider<FlagsController, CountriesGameProcessControl>((ref) {
  return FlagsController();
});

class FlagsController extends StateNotifier<CountriesGameProcessControl> {
  FlagsController() : super(CountriesGameProcessControl(3)..init());

  void next() {
    state.next();
    var f = state.copy();
    state = f;
  }

  void clear() {
    state.init();
  }
}
