import 'dart:math';

import 'package:countries/models/countries_list.dart';
import 'package:countries/models/country.dart';


class CountriesGameProcessControl {
  int index = -1;
  int correctNameIndex = 0;
  int correctAnswers = 0;
  int answered = 0;
  final int howManyWrongCountries;
  late Country correctCountry;
  final List<Country> wrongCountries = [];
  final List<String> names = [];
  final List<Country> source = [];

  CountriesGameProcessControl(this.howManyWrongCountries);

  void init(List<Country> newSource) {
    source.clear();
    source.addAll(newSource);
    source.shuffle(Random(DateTime.now().second));
    correctAnswers = 0;
    answered = 0;
    next();
  }

  void newSource(List<Country> countriesSource) {
    init(countriesSource);
  }

  CountriesGameProcessControl copy() {
    var f = CountriesGameProcessControl(howManyWrongCountries);
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
    names.add(correctCountry.name!.common!);
    // debugPrint('Correct name: ${correctCountry.name!.common!}');
    for (var e in wrongCountries) {
      names.add(e.name!.common!);
    }
    names.shuffle(Random(DateTime.now().second));
    correctNameIndex = names.indexWhere(
        (e) => e.toLowerCase() == correctCountry.name!.common!.toLowerCase());
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
      if (item.cca2!.toLowerCase() != correctCountry.cca2!.toLowerCase()) {
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
