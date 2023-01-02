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
    Duration duration = const Duration(seconds: 4),
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

  static showMaterialBanner() {
    const materialBanner = MaterialBanner(
      content: Text("Conten"),
      actions: [
        Icon(Icons.abc_outlined),
      ],
    );

    messengerKey.currentState!.showMaterialBanner(materialBanner);
  }
}
