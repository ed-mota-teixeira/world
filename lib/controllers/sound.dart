import 'package:audioplayers/audioplayers.dart';
import 'package:countries/controllers/app_preferences.dart';
import 'package:countries/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final soundProvider = StateProvider<bool>((ref) => Sound().isEnabled);

// A provider which computes whether the user have sound or not
final haveSoundProvider =
    Provider<bool>((ref) => ref.watch(soundProvider) != false);

class Sound {
  final buttonClickPlayer = AudioPlayer();
  final correctSelectionPlayer = AudioPlayer();
  final wrongSelectionPlayer = AudioPlayer();
  final winner80Sound = AudioPlayer();
  final looseSound = AudioPlayer();
  final winner60Sound = AudioPlayer();

  bool isEnabled = true;

  Sound._internal();
  static final Sound _instance = Sound._internal();
  factory Sound() => _instance;

  Future<void> setSources() async {
    await buttonClickPlayer
        .setSource(AssetSource(kButtonSound))
        .catchError((e) => debugPrint(e.toString()));
    await correctSelectionPlayer.setSource(AssetSource(kCorrectSound));
    await wrongSelectionPlayer.setSource(AssetSource(kWrongSound));
    await winner80Sound.setSource(AssetSource(kWin80Sound));
    await looseSound.setSource(AssetSource(kFailedSound));
    await winner60Sound.setSource(AssetSource(kWin60Sound));

    isEnabled = await AppPreferences().soundEnabled();
  }

  void disposeAll() {
    winner60Sound.dispose();
    looseSound.dispose();
    winner80Sound.dispose();
    buttonClickPlayer.dispose();
    correctSelectionPlayer.dispose();
    wrongSelectionPlayer.dispose();
  }
}
