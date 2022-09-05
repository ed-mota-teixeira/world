import 'package:countries/enums/transitions_enums.dart';
import 'package:countries/utils/routing/route_names.dart';
import 'package:countries/views/pages/capitals_game_page.dart';
import 'package:countries/views/pages/error_page.dart';
import 'package:countries/views/pages/flags_game_page.dart';
import 'package:countries/views/pages/menu_page.dart';
import 'package:countries/views/pages/start_page.dart';
import 'package:countries/views/transitions/transition_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Countries',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blueGrey, background: Colors.blueGrey)),
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
            var easy = settings.arguments as bool?;
            return createRoute(FlagsGamePage(easy: easy), TransitionType.fade);
          case kCapitalsGameRoute:
            return createRoute(const CapitalsGamePage(), TransitionType.fade);
          default:
            return createRoute(const ErrorPage(), TransitionType.fade);
        }
      },
    );
  }
}
