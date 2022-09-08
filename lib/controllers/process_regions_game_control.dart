import 'dart:math';

import 'package:countries/models/countries_list.dart';
import 'package:countries/models/country.dart';
import 'package:quiver/strings.dart';

class RegionsGameProcessControl {
  int index = -1;
  int correctNameIndex = 0;
  int correctAnswers = 0;
  int answered = 0;

  final int howManyWrongCountries = 3;
  late Country correctCountry;
  final List<Country> wrongCountries = [];
  final List<String> names = [];
  final List<Country> source = [];
  final int processType; // 0 == regions, 1 == subregions
  final List<String> availableRegions = [];
  final List<String> availableSubregions = [];

  RegionsGameProcessControl(this.processType);

  void init(List<Country> newSource) {
    availableRegions.clear();
    names.clear();
    source.clear();
    source.addAll(newSource);
    source.shuffle(Random(DateTime.now().second));
    correctAnswers = 0;
    answered = 0;
    for (var element in source) {
      if (element.region != null) {
        if (isNotBlank(element.region!.name)) {
          availableRegions.add(element.region!.name);
        }
      }
      if (isNotBlank(element.subregion)) {
        availableSubregions.add(element.subregion!);
      }
    }
    var l = availableRegions.toSet().toList();
    var sl = availableSubregions.toSet().toList();
    availableRegions.clear();
    availableRegions.addAll(l);
    availableSubregions.clear();
    availableSubregions.addAll(sl);
    next();
  }

  RegionsGameProcessControl copy() {
    var f = RegionsGameProcessControl(howManyWrongCountries);
    f.names.clear();
    f.names.addAll(names);
    f.correctNameIndex = correctNameIndex;
    f.correctCountry = correctCountry;
    f.wrongCountries.clear();
    f.wrongCountries.addAll(wrongCountries);
    f.index = index;
    f.source.clear();
    f.source.addAll(source);
    f.answered = answered;
    f.correctAnswers = correctAnswers;
    return f;
  }

  void next() {
    correctCountry = nextCorrectCountry();
    wrongCountries.clear();
    names.clear();
    wrongCountries.addAll(provideWrongCountries(howManyWrongCountries));
    names.add(processType == 0
        ? correctCountry.region!.name
        : correctCountry.subregion!);
    // debugPrint('Correct name: ${correctCountry.name!.common!}');
    for (var e in wrongCountries) {
      if (processType == 0) names.add(e.region!.name);
      if (processType == 1) names.add(e.subregion!);
    }
    names.shuffle(Random(DateTime.now().second));
    correctNameIndex = names.indexWhere((e) =>
        e.toLowerCase() ==
        (processType == 0
            ? correctCountry.region!.name.toLowerCase()
            : correctCountry.subregion!.toLowerCase()));
  }

  // Must be called before provideWrongCountries method
  Country nextCorrectCountry() {
    index = index + 1 >= source.length ? 0 : ++index;
    return source.elementAt(index);
  }

  // Must be called after nextCorrectCountry method
  List<Country> provideWrongCountries(int quantity) {
    final List<Country> countries = [];
    int howManySoFar = 0;

    var c = Random().nextInt(CountriesList().list.length - 2);
    while (howManySoFar < quantity) {
      var item = CountriesList().list.elementAt(c);
      var wv = processType == 0 ? item.region!.name : item.subregion!;
      var cv = processType == 0
          ? correctCountry.region!.name
          : correctCountry.subregion!;

      if (wv.toLowerCase() != cv.toLowerCase()) {
        countries.add(item);
        howManySoFar = howManySoFar + 1;
        if (howManySoFar >= quantity) {
          break;
        }
      }
      c = c >= CountriesList().list.length ? 0 : c + 1;
    }

    return countries;
  }
}
