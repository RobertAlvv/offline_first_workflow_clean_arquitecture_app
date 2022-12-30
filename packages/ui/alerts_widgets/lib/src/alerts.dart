import 'package:flutter/material.dart';

class Alerts {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static snackbar({
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

  // static toast({
  //   ToastGravity position = ToastGravity.CENTER,
  //   required BuildContext context,
  //   required Widget child,
  // }) {
  //   FToast fToast = FToast();

  //   fToast.init(context);

  //   fToast.showToast(
  //     gravity: position,
  //     child: child,
  //   );
  // }

  // static informationDialog({
  //   required bool doubleBack,
  //   required Color backgroundColor,
  //   void Function()? action,
  //   String type = '',
  //   String title = '',
  //   Widget? message,
  //   String labelButton = 'Aceptar',
  //   String image = 'assets/images/confirmation_dialog_success.json',
  //   bool hasCloseButton = false,
  // }) {
  //   showDialog(
  //     context: Nav.navigatorKey.currentState!.context,
  //     barrierDismissible: false,
  //     barrierColor: backgroundColor,
  //     builder: (_) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: DialogGeneralWidget(
  //           image: image,
  //           message: message ??
  //               RichText(
  //                 textAlign: TextAlign.center,
  //                 text: const TextSpan(),
  //               ),
  //           action: () {
  //             Nav.pop();
  //             if (doubleBack) {
  //               Nav.pop();
  //             }
  //             if (action != null) {
  //               action();
  //             }
  //           },
  //           titleTypeDialog: type,
  //           title: title,
  //           labelButton: labelButton,
  //           closeButton: hasCloseButton
  //               ? ElevatedButtonInfiniteOutlined(
  //                   label: 'Cancelar',
  //                   action: () => Nav.pop(false),
  //                 )
  //               : null,
  //         ),
  //       );
  //     },
  //   );
  // }

  // static actionDialog({
  //   required bool doubleBack,
  //   required Color backgroundColor,
  //   String type = '',
  //   String title = '',
  //   Widget? message,
  //   String labelButton = 'Aceptar',
  //   String image = 'assets/images/confirmation_dialog_success.json',
  //   bool hasCloseButton = false,
  //   void Function()? action,
  // }) {
  //   showDialog(
  //     context: Nav.navigatorKey.currentState!.context,
  //     barrierDismissible: false,
  //     barrierColor: backgroundColor,
  //     builder: (_) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: DialogGeneralWidget(
  //           image: image,
  //           message: message ??
  //               RichText(
  //                 textAlign: TextAlign.center,
  //                 text: const TextSpan(),
  //               ),
  //           action: action,
  //           titleTypeDialog: type,
  //           title: title,
  //           labelButton: labelButton,
  //           closeButton: hasCloseButton
  //               ? ElevatedButtonInfiniteOutlined(
  //                   label: 'Cancelar',
  //                   action: () => Nav.pop(false),
  //                 )
  //               : null,
  //         ),
  //       );
  //     },
  //   );
  // }
}
