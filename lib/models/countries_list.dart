import 'package:countries/models/country.dart';

class CountriesList {
  late List<Country> list;

  CountriesList._internal();
  static final CountriesList _instance = CountriesList._internal();

  factory CountriesList() => _instance;

}
