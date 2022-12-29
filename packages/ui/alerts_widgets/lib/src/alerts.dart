import 'package:flutter/material.dart';

class Alerts {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static snackbar({required String message, Color? color, Color? colorText}) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor:
          color ?? const Color.fromARGB(255, 195, 74, 74).withAlpha(32),
      content: Row(
        children: [
          Icon(
            Icons.cancel_outlined,
            color: colorText ?? const Color.fromARGB(255, 195, 74, 74),
          ),
          const SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(
              color: colorText ?? const Color.fromARGB(255, 195, 74, 74),
              fontSize: 14,
            ),
          )
        ],
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
