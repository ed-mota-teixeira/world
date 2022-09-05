import 'dart:async';
import 'dart:math';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:countries/controllers/country_provider.dart';
import 'package:countries/controllers/process_countries_game_control.dart';
import 'package:countries/models/countries_list.dart';
import 'package:countries/utils/constants.dart';
import 'package:countries/views/widgets/final_score_indicator_widget.dart';
import 'package:countries/views/widgets/flag_widget.dart';
import 'package:countries/views/widgets/selection_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlagsGamePage extends ConsumerStatefulWidget {
  final bool? easy;
  const FlagsGamePage({super.key, this.easy = false});

  @override
  createState() => _FlagsGamePage();
}

class _FlagsGamePage extends ConsumerState<FlagsGamePage> {
  double _progressValue = 0.0;
  double _startValue = 0.0;
  bool done = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    _progressValue = 0.0;
    _startValue = 0.0;
    done = false;
    CountriesList().list.shuffle(Random(DateTime.now().second));
    ref.read(countryProvider).init();
    if (widget.easy != null) {
      if (widget.easy!) {
        ref.read(countryProvider).changeSource(easyCountriesCode);
      }
    }
  }

  Widget _flag() {
    var h = MediaQuery.of(context).size.height * 0.3;
    var w = MediaQuery.of(context).size.width * 0.4;
    return LimitedBox(
        maxHeight: h,
        maxWidth: w,
        child: Flag(
            country: ref.read(countryProvider).correctCountry,
            width: w,
            height: h));
  }

  void _updateProgress(bool correctPressed) {
    ref.read(countryProvider).answered = ref.read(countryProvider).answered + 1;

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _progressValue =
            ref.read(countryProvider).correctAnswers / 100 * kMaxAnswersPerGame;
        done = ref.read(countryProvider).answered >= kMaxAnswersPerGame;
      });

      if (done) {
        Future.delayed(
            const Duration(milliseconds: 300),
            () => setState(() {
                  _startValue = (ref.read(countryProvider).correctAnswers *
                      100 /
                      kMaxAnswersPerGame);
                }));
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          ref.read(countryProvider.notifier).next();
        });
      }
    });
  }

  Widget _tryAgainButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
          child: const Text('Restart',
              maxLines: 1, overflow: TextOverflow.ellipsis),
          onPressed: () {
            _start();
            setState(() {
              done = false;
              _progressValue = 0;
              _startValue = 0.0;
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var control = ref.watch(countryProvider);

    return SafeArea(
        child: Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: true, title: const Text('FLAGS')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (done)
              FinalScoreIndicatorWidget(
                  percentValue: _progressValue, percentCounter: _startValue),
            Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: !done,
                child: _flag()),
            Visibility(
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: !done,
              child: SelectionPad(
                buttonColor: Theme.of(context).primaryColor,
                buttonHeight: 64,
                buttonWidth: MediaQuery.of(context).size.width * 0.4,
                textColor: Colors.white,
                texts: ref.read(countryProvider).names,
                correctIndex: control.correctNameIndex,
                onCorrectPressed: () {
                  // TODO: show congratulations or victory sound
                  //  debugPrint('Well done!');
                  control.correctAnswers = control.correctAnswers + 1;
                  _updateProgress(true);
                },
                onIncorrectPressed: () {
                  // debugPrint('No no. Incorrect!');
                  _updateProgress(false);
                  AnimatedSnackBar.material(
                    duration: const Duration(milliseconds: 700),
                    control.correctCountry.name!.common!,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    type: AnimatedSnackBarType.warning,
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    desktopSnackBarPosition: DesktopSnackBarPosition.topRight,
                  ).show(context);
                },
              ),
            ),
            if (done) _tryAgainButton(),
          ],
        ),
      ),
    ));
  }
}
