import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FinalScoreIndicatorWidget extends ConsumerWidget {
  final double percentValue;
  final num percentCounter;

  const FinalScoreIndicatorWidget(
      {super.key, required this.percentValue, required this.percentCounter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircularPercentIndicator(
      radius: 120.0,
      lineWidth: 24.0,
      animation: true,
      percent: percentValue,
      center: AnimatedFlipCounter(
        duration: const Duration(milliseconds: 1200),
        value: percentCounter,
        fractionDigits: 0,
        curve: Curves.decelerate,
        suffix: "%",
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      header: const Padding(
        padding: EdgeInsets.all(24),
        child: Text("Correct answers",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      animationDuration: 1000,
      progressColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.black12,
    );
  }
}
