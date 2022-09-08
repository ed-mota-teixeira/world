import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextSelectionItem extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double width;
  final bool isCorrect;
  final VoidCallback? onPressed;

  const TextSelectionItem(
      {super.key,
      required this.text,
      required this.color,
      required this.height,
      required this.width,
      this.isCorrect = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool android = !kIsWeb ? Platform.isAndroid : false;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: android
                    ? Theme.of(context).textTheme.bodySmall!.fontSize
                    : Theme.of(context).textTheme.titleLarge!.fontSize),
          ),
        ),
      ),
    );
  }
}
