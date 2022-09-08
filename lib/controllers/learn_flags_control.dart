import 'package:countries/models/countries_list.dart';
import 'package:countries/models/country.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final learnProvider = StateNotifierProvider<LearnController, Country>((ref) {
  return LearnController(CountriesList().list.elementAt(0))..start();
});

class LearnController extends StateNotifier<Country> {
  int _index = 0;

  LearnController(super.state);

  void start() {
    _index = 0;
    CountriesList()
        .list
        .sort((a, b) => a.name!.common!.compareTo(b.name!.common!));
    state = CountriesList().list.elementAt(0);
  }

  void next() {
    _index = _index >= CountriesList().list.length - 1 ? 0 : ++_index;
    state = CountriesList().list.elementAt(_index);
  }

  void previous() {
    _index = _index <= 0 ? CountriesList().list.length - 1 : --_index;
    state = CountriesList().list.elementAt(_index);
  }
}
