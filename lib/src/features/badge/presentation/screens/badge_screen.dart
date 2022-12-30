import 'package:alerts_widgets/alerts_widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/widgets/badget_card.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  late Connectivity connectivity;
  ConnectivityResult? oldConnectivityResult;

  @override
  void didChangeDependencies() async {
    connectivity = Connectivity();

    final firstCheckConnectivity = await connectivity.checkConnectivity();

    if (firstCheckConnectivity == ConnectivityResult.none) {
      Alerts.snackbar(
        message: "No tienes conexión a internet",
        color: Colors.red,
        icon: Icons.signal_wifi_bad,
        duration: const Duration(seconds: 20),
      );
    }

    Future.delayed(
      const Duration(seconds: 3),
      () {
        connectivity.onConnectivityChanged.listen((event) {
          Alerts.messengerKey.currentState?.hideCurrentSnackBar();
          if (event == ConnectivityResult.none) {
            Alerts.snackbar(
              message: "No tienes conexión a internet",
              color: Colors.red,
              icon: Icons.signal_wifi_bad,
              duration: const Duration(seconds: 20),
            );
          } else if ((event == ConnectivityResult.wifi) &&
              oldConnectivityResult != null &&
              oldConnectivityResult != ConnectivityResult.mobile) {
            Alerts.snackbar(
              message: "De nuevo en linea",
              color: Colors.green,
              icon: Icons.check,
            );
          } else if (event == ConnectivityResult.mobile &&
              oldConnectivityResult != null &&
              oldConnectivityResult != ConnectivityResult.wifi) {
            Alerts.snackbar(
              message: "De nuevo en linea",
              color: Colors.green,
              icon: Icons.check,
            );
          }
          oldConnectivityResult = event;
        });
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(height: 60),
            _BadgeAppBar(),
            _BadgeBody(),
          ],
        ),
      ),
    );
  }
}

class _BadgeAppBar extends StatelessWidget {
  const _BadgeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60,
      child: Text(
        "APP DIVISA",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _BadgeBody extends StatelessWidget {
  const _BadgeBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BadgeCard(),
        ],
      ),
    );
  }
}
