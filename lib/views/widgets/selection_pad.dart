import 'package:countries/views/widgets/text_selection_item.dart';
import 'package:flutter/material.dart';

class SelectionPad extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final Color buttonColor;
  final Color textColor;
  final List<String> texts;
  final int correctIndex;
  final VoidCallback onCorrectPressed;
  final VoidCallback onIncorrectPressed;
  final double opacity;

  const SelectionPad(
      {super.key,
      required this.buttonColor,
      required this.textColor,
      required this.buttonHeight,
      required this.buttonWidth,
      required this.texts,
      required this.correctIndex,
      required this.onCorrectPressed,
      required this.onIncorrectPressed,
      this.opacity = 1});

  @override
  Widget build(BuildContext context) {
    // debugPrint('Correct index: $correctIndex');
    return Container(
      width: double.maxFinite,
      color: Colors.transparent,
      child: Column(children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // implement the number keys (from 0 to 9) with the NumberButton widget
          // the NumberButton widget is defined in the bottom of this file
          children: [
            TextSelectionItem(
              opacity: correctIndex == 0 ? 1 : opacity,
              text: texts.elementAt(0),
              width: buttonWidth,
              height: buttonHeight,
              color: buttonColor,
              isCorrect: correctIndex == 0,
              onPressed:
                  correctIndex == 0 ? onCorrectPressed : onIncorrectPressed,
            ),
            TextSelectionItem(
              opacity: correctIndex == 1 ? 1 : opacity,
              text: texts.elementAt(1),
              width: buttonWidth,
              height: buttonHeight,
              color: buttonColor,
              isCorrect: correctIndex == 1,
              onPressed:
                  correctIndex == 1 ? onCorrectPressed : onIncorrectPressed,
            ),
          ],
        ),
        const SizedBox(width: 10, height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // implement the number keys (from 0 to 9) with the NumberButton widget
          // the NumberButton widget is defined in the bottom of this file
          children: [
            TextSelectionItem(
              opacity: correctIndex == 2 ? 1 : opacity,
              text: texts.elementAt(2),
              width: buttonWidth,
              height: buttonHeight,
              color: buttonColor,
              isCorrect: correctIndex == 2,
              onPressed:
                  correctIndex == 2 ? onCorrectPressed : onIncorrectPressed,
            ),
            TextSelectionItem(
              opacity: correctIndex == 3 ? 1 : opacity,
              text: texts.elementAt(3),
              width: buttonWidth,
              height: buttonHeight,
              color: buttonColor,
              isCorrect: correctIndex == 3,
              onPressed:
                  correctIndex == 3 ? onCorrectPressed : onIncorrectPressed,
            ),
          ],
        ),
        const SizedBox(height: 12),
      ]),
    );
  }
}
