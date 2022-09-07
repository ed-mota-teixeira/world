import 'package:countries/models/country.dart';

class CountriesList {
  late List<Country> list;

  CountriesList._internal();
  static final CountriesList _instance = CountriesList._internal();

  factory CountriesList() => _instance;

  List<Country> fromCca2(List<String> cca2List) {
    return list.where((element) => cca2List.contains(element.cca2!)).toList();
  }

  List<Country> notFromCca2(List<String> cca2List) {
    return list.where((element) => !cca2List.contains(element.cca2!)).toList();
  }
}
