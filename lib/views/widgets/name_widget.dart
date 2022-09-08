import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NameWidget extends StatelessWidget {
  final String text;
  const NameWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final android = kIsWeb ? false : Platform.isAndroid;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: android
                  ? Theme.of(context).textTheme.subtitle1!.fontSize
                  : Theme.of(context).textTheme.headline4!.fontSize,
              color: Colors.white),
        ),
      ),),
    );
  }
}
