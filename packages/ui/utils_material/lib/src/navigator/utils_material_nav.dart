import 'package:flutter/material.dart';

class UtilsMaterialNav {
  UtilsMaterialNav._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> pushName(String route, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed<void>(route, arguments: arguments);
  }

  static Future<T?> push<T extends Object?>(Route<T> newRoute) {
    return navigatorKey.currentState!.push<T>(newRoute);
  }

  static void popUntilName(String route) {
    return navigatorKey.currentState!.popUntil(ModalRoute.withName(route));
  }

  static void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }

  static Future<void> replacementName(String route) {
    return navigatorKey.currentState!.pushReplacementNamed<void, void>(route);
  }

  static Future<void> popAndPushName(String route) {
    return navigatorKey.currentState!.popAndPushNamed<void, void>(route);
  }

  static Future<void> popAndPush(String route) {
    return navigatorKey.currentState!.popAndPushNamed<void, void>(route);
  }

  static Future<void> pushReplacement<T extends Object?>(Route<T> newRoute) {
    return navigatorKey.currentState!.pushReplacement<void, void>(newRoute);
  }

  static Future<void> pushByAnimation(
      Widget Function() view, Duration transitionDuration) {
    return navigatorKey.currentState!.push(
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => view(),
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: transitionDuration,
      ),
    );
  }

  static Future<void> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute) async {
    return navigatorKey.currentState!
        .pushAndRemoveUntil<void>(newRoute, (_) => false);
  }
}
