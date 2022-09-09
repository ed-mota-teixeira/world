import 'dart:io';

import 'package:countries/enums/transitions_enums.dart';
import 'package:countries/models/game_page_argument.dart';
import 'package:countries/utils/routing/route_names.dart';
import 'package:countries/views/pages/error_page.dart';
import 'package:countries/views/pages/game_page.dart';
import 'package:countries/views/pages/learn_flags_page.dart';
import 'package:countries/views/pages/menu_page.dart';
import 'package:countries/views/pages/region_game_page.dart';
import 'package:countries/views/pages/start_page.dart';
import 'package:countries/views/transitions/transition_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('WORLD QUIZ');
      setWindowMaxSize(const Size(1056, 1064));
      setWindowMinSize(const Size(800, 656));
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Countries',
      theme: ThemeData(
        fontFamily: 'BaiJam',
        // primaryColor: const Color(0xff344955),
        primaryColor: const Color(0xff4a4977),
        scaffoldBackgroundColor: const Color(0xffbdbdbd),
        useMaterial3: true,
        // primaryColor: const Color(0xff4A6570),
      ),
      initialRoute: kStartRoute,
      onUnknownRoute: (settings) =>
          createRoute(const ErrorPage(), TransitionType.fade),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case kStartRoute:
            return createRoute(const StartPage(), TransitionType.fade);
          case kMenuRoute:
            return createRoute(const MenuPage(), TransitionType.fade);
          case kFlagsGameRoute:
          case kCapitalsGameRoute:
            var data = settings.arguments as GamePageArgument;
            return createRoute(GamePage(data: data), TransitionType.fade);
          case kLearnFlagsRoute:
            return createRoute(const LearnFlagsPage(), TransitionType.fade);
          case kRegionsGameRoute:
            var data = settings.arguments as GamePageArgument;
            return createRoute(RegionGamePage(data: data), TransitionType.fade);
          default:
            return createRoute(const ErrorPage(), TransitionType.fade);
        }
      },
    );
  }
}
