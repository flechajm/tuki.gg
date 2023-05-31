import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../main.dart';
import '../../../presentation/screens/home/home_screen.dart';

class GeneralNavigator {
  static void push(Widget screen, {PageTransitionType transitionType = PageTransitionType.rightToLeft}) {
    navigatorKey.currentState?.push(getRoute(screen, transitionType: transitionType));
  }

  static void pushReplacement(Widget screen, {PageTransitionType transitionType = PageTransitionType.rightToLeft}) {
    navigatorKey.currentState?.pushReplacement(getRoute(screen, transitionType: transitionType));
  }

  static void pop() {
    if (navigatorKey.currentState != null) {
      if (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState?.pop();
      } else {
        GeneralNavigator.pushReplacement(const HomeScreen());
      }
    }
  }

  static void pushAndRemoveUntil(Widget screen) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );
  }

  static PageTransition getRoute(
    Widget screen, {
    PageTransitionType transitionType = PageTransitionType.rightToLeft,
  }) {
    String routeName = screen.toString().replaceAll("Screen", "");

    return PageTransition(
      child: screen,
      type: transitionType,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      settings: RouteSettings(name: routeName),
    );
  }
}
