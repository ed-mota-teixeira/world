import 'package:countries/models/country.dart';
import 'package:quiver/strings.dart';

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

  List<Country> fromCca2WithCapitals(List<String> cca2List) {
    return fromCca2(cca2List)
        .where((e) => e.capital != null && isNotEmpty(e.capital!.first))
        .toList();
  }

  List<Country> notFromCca2WithCapitals(List<String> cca2List) {
    return notFromCca2(cca2List)
        .where((e) => e.capital != null && isNotEmpty(e.capital!.first))
        .toList();
  }

  List<Country> allWithCapitals() {
    return list
        .where((e) => e.capital != null && isNotEmpty(e.capital!.first))
        .toList();
  }
}
