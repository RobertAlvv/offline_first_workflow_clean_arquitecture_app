import 'package:flutter/material.dart';
import 'package:utils_material/src/scaffold_messenger/scaffold_messenger.dart';

extension Snackbars on UtilsMaterialMessenger {
  static show({
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
    UtilsMaterialMessenger.messengerKey.currentState!.showSnackBar(snackBar);
  }
}
