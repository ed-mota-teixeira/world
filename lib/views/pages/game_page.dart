import 'dart:math';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:countries/controllers/country_provider.dart';
import 'package:countries/controllers/sound.dart';
import 'package:countries/models/game_page_argument.dart';
import 'package:countries/utils/constants.dart';
import 'package:countries/views/widgets/final_score_indicator_widget.dart';
import 'package:countries/views/widgets/selection_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamePage extends ConsumerStatefulWidget {
  final GamePageArgument data;

  const GamePage({super.key, required this.data});

  @override
  createState() => _GamePage();
}

class _GamePage extends ConsumerState<GamePage> {
  double _progressValue = 0.0;
  double _startValue = 0.0;
  bool done = false;
  bool _good = false;
  bool _doNotTouch = false;
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    _opacity = 1;
    _doNotTouch = false;
    _progressValue = 0.0;
    _startValue = 0.0;
    _good = false;
    done = false;
    widget.data.list.shuffle(Random(DateTime.now().second));
    ref.read(countryProvider).init(widget.data.list);
  }

  void _updateProgress(bool correctPressed) {
    ref.read(countryProvider).answered = ref.read(countryProvider).answered + 1;

    if (correctPressed) {
      setState(() {
        _good = true;
        _doNotTouch = true;
        _opacity = 0;
      });
    } else {
      setState(() {
        _doNotTouch = true;
        _opacity = 0;
      });
    }

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _progressValue = ref.read(countryProvider).correctAnswers /
              100 *
              kMaxAnswersPerGame;
          done = ref.read(countryProvider).answered >= kMaxAnswersPerGame;
        });
      }

      if (done) {
        var ansW = ref.read(countryProvider).correctAnswers;
        if (Sound().isEnabled) {
          if (ansW >= 8) {
            Sound().winner80Sound.play(AssetSource(kWin80Sound));
          } else if (ansW > 5) {
            Sound().winner60Sound.play(AssetSource(kWin60Sound));
          } else {
            Sound().looseSound.play(AssetSource(kFailedSound));
          }
        }

        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _good = false;
              _doNotTouch = false;
              _opacity = 1;
              _startValue = (ansW * 100 / kMaxAnswersPerGame);
            });
          }
        });
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (_good && mounted) {
            setState(() {
              _good = false;
              _doNotTouch = false;
              _opacity = 1;
            });
          } else if (!_good && mounted) {
            setState(() {
              _doNotTouch = false;
              _opacity = 1;
            });
          }
          if (mounted) ref.read(countryProvider.notifier).next();
        });
      }
    });
  }

  Widget _tryAgainButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: OutlinedButton(
          child: Text(
            'RESTART',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () {
            _start();
            if (mounted) {
              setState(() {
                _doNotTouch = false;
                done = false;
                _good = false;
                _progressValue = 0;
                _startValue = 0.0;
              });
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var control = ref.watch(countryProvider);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true, title: Text(widget.data.title)),
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
                child: widget.data.guessWidget),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: _good,
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Colors.orange,
                ),
              ),
            ),
            Visibility(
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: !done,
              child: SelectionPad(
                opacity: _opacity,
                buttonColor: Theme.of(context).primaryColor,
                buttonHeight: 64,
                buttonWidth: MediaQuery.of(context).size.width * 0.4,
                textColor: Colors.white,
                texts: ref.read(countryProvider).names,
                correctIndex: control.correctNameIndex,
                onCorrectPressed: () {
                  if (_doNotTouch) return;
                  if (Sound().isEnabled) {
                    Sound()
                        .correctSelectionPlayer
                        .play(AssetSource(kCorrectSound));
                  }
                  control.correctAnswers = control.correctAnswers + 1;
                  _updateProgress(true);
                },
                onIncorrectPressed: () {
                  if (_doNotTouch) return;
                  if (Sound().isEnabled) {
                    Sound().wrongSelectionPlayer.play(AssetSource(kWrongSound));
                  }
                  _updateProgress(false);
                  if (mounted) {
                    AnimatedSnackBar.material(
                      duration: const Duration(milliseconds: 700),
                      control.correctCountry.name!.common!,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      type: AnimatedSnackBarType.warning,
                      mobileSnackBarPosition: MobileSnackBarPosition.top,
                      desktopSnackBarPosition:
                          DesktopSnackBarPosition.topCenter,
                    ).show(context);
                  }
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
