import 'package:flutter/material.dart';

import 'country.dart';

class GamePageArgument {
  final List<Country> list;
  final Widget guessWidget;
  final String title;
  final int extra;

  GamePageArgument(this.list, this.guessWidget,
      {this.title = 'WORLD QUIZ', this.extra = 0});
}
