import 'dart:math';

import 'package:countries/models/countries_list.dart';
import 'package:countries/models/country.dart';
import 'package:quiver/strings.dart';

const List<String> easyCountriesCode = [
  'FR',
  'ES',
  'DE',
  'JP',
  'RU',
  'CA',
  'IT',
  'GB',
  'US',
  'BR',
  'TR',
  'PL',
  'AU',
  'ID',
  'DK',
  'MX',
  'CH',
  'MA',
  'CN',
  'UA',
  'IN',
  'IE',
  'KR',
  'IL',
  'VN',
  'GR',
];

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

  void init() {
    source.clear();
    source.addAll(CountriesList().list);
    correctAnswers = 0;
    answered = 0;
    next();
  }

  void changeSource(List<String> cca2) {
    source.clear();
    if (cca2.isEmpty) {
      source.addAll(CountriesList().list);
    } else {
      source.addAll(CountriesList().list.where((c) =>
          cca2.firstWhere((a) => a.toLowerCase() == c.cca2!.toLowerCase(),
              orElse: () => ' ') ==
          c.cca2!));
    }
    correctAnswers = 0;
    answered = 0;
    next();
  }

  List<String> processSourceWhereCountryCapitalExists() {
    List<String> src = [];

    for (var e in CountriesList().list) {
      if (e.capital != null && e.capital!.isNotEmpty) {
        if (isNotBlank(e.capital!.first)) {
          src.add(e.cca2!);
        }
      }
    }

    return src;
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
      // debugPrint('Incorrect name: ${e.name!.common!}');
    }
    names.shuffle(Random(DateTime.now().second));
    correctNameIndex = names.indexWhere(
        (e) => e.toLowerCase() == correctCountry.name!.common!.toLowerCase());
  }

  Country nextCorrectCountry() {
    index = index + 1 >= source.length ? 0 : ++index;
    return source.elementAt(index);
  }

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
