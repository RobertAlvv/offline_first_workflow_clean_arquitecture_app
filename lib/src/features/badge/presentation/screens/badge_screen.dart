import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:utils_material/utils_material.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/widgets/badget_card.dart';

import '../../../../core/injection_dependency/injection_container.dart';
import '../../../checking_internet/presentation/bloc/check_internet/check_internet_bloc.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  final BadgeBloc? badgeBloc = serviceLocator<BadgeBloc>();

  late CheckInternetBloc checkInternetBloc;

  @override
  void didChangeDependencies() {
    checkInternetBloc = context.read<CheckInternetBloc>();
    checkInternetBloc.add(OnCheckInternet());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => badgeBloc!,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                SizedBox(height: 60),
                _BadgeAppBar(),
                _BadgeBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeAppBar extends StatelessWidget {
  const _BadgeAppBar();

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
    final badgeBloc = context.watch<BadgeBloc>();
    final badgeAtCreated = badgeBloc.state.badge.createdAt;

    final formatDate = DateFormat("dd/MM/yyyy hh:mm a");

    return BlocListener<CheckInternetBloc, CheckInternetState>(
      listener: (context, state) {
        UtilsMaterialMessenger.messengerKey.currentState?.hideCurrentSnackBar();
        if (state.hasInternet == true) {
          Snackbars.show(
            message: "De nuevo en linea",
            color: Colors.green,
            icon: Icons.check,
          );
        } else {
          Snackbars.show(
            message: "No tienes conexión a internet",
            color: Colors.red,
            icon: Icons.signal_wifi_bad,
            duration: const Duration(seconds: 4),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BadgeCard(),
            const SizedBox(height: 20),
            if (badgeAtCreated != null)
              CardWidget(
                height: 80,
                child: Text(
                    '''La información viene de tu base de datos local\nUltima fecha de actualizacion: ${formatDate.format(badgeAtCreated)}'''),
              ),
          ],
        ),
      ),
    );
  }
}
