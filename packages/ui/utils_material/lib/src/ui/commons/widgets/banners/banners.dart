import 'package:flutter/material.dart';
import 'package:utils_material/src/scaffold_messenger/scaffold_messenger.dart';

extension Banners on UtilsMaterialMessenger {
  static show({
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

    UtilsMaterialMessenger.messengerKey.currentState!
        .showMaterialBanner(materialBanner);

    Future.delayed(
        duration,
        () => UtilsMaterialMessenger.messengerKey.currentState!
            .hideCurrentMaterialBanner());
  }
}
