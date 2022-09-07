import 'package:flutter/material.dart';

import 'country.dart';

class GamePageArgument {
  final List<Country> list;
  final Widget guessWidget;

  GamePageArgument(this.list, this.guessWidget);
}
