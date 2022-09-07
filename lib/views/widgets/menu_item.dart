import 'package:flutter/material.dart';

class GameMainMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GameMainMenuItem(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 40, start: 16, end: 16),
     // width: MediaQuery.of(context).size.width / 2,
      child: RawMaterialButton(
          onPressed: onPressed,
          fillColor: Theme.of(context).primaryColor,
          splashColor: Colors.blueGrey,
          highlightColor: Colors.blueGrey,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis))),
    );
  }
}
