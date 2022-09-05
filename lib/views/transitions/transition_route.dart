import 'package:countries/enums/transitions_enums.dart';
import 'package:countries/utils/constants.dart';
import 'package:flutter/material.dart';

PageRouteBuilder createRoute(Widget page, TransitionType transitionType) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: kDefaultAnimTiming),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (transitionType == TransitionType.fade) {
          return FadeTransition(opacity: animation, child: child);
        } else if (transitionType == TransitionType.slideUp) {
          return SlideTransition(
            position: Tween(
                    begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        } else {
          return SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return page;
      });
}
