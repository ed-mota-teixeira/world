import 'package:countries/controllers/process_regions_game_control.dart';
import 'package:countries/models/countries_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final regionProvider =
    StateNotifierProvider<RegionsController, RegionsGameProcessControl>((ref) {
  return RegionsController();
});

class RegionsController extends StateNotifier<RegionsGameProcessControl> {
  RegionsController()
      : super(RegionsGameProcessControl()..init(CountriesList().list));

  void next() {
    state.next();
    var f = state.copy();
    state = f;
  }

}
