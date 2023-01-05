import 'package:flutter/material.dart';

class ScaffoldMessengerLP {
  ScaffoldMessengerLP._();

  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar({
    required String message,
    required Color color,
    Color? colorText,
    required IconData icon,
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      duration: duration,
      elevation: 0,
      backgroundColor: color,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          )
        ],
      ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showMaterialBanner({
    Color? backgroundColor,
    required Widget content,
    required List<Widget> actions,
    Widget? leading,
    Duration duration = const Duration(seconds: 4),
  }) {
    final materialBanner = MaterialBanner(
      backgroundColor: backgroundColor,
      content: content,
      actions: actions,
      leading: leading,
    );

    messengerKey.currentState!.showMaterialBanner(materialBanner);

    Future.delayed(
        duration, () => messengerKey.currentState!.hideCurrentMaterialBanner());
  }
}
