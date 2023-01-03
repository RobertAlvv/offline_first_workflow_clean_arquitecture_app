import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first_workflow/src/features/checking_internet/domain/usecases/check_internet.dart';

import 'app.dart';

import '../features/checking_internet/domain/usecases/on_connectivity_change.dart';
import '../features/checking_internet/presentation/bloc/check_internet/check_internet_bloc.dart';
import 'injection_dependency/injection_container.dart';

class AppBloc extends StatelessWidget {
  const AppBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CheckInternetBloc(
            serviceLocator<CheckInternet>(),
            serviceLocator<OnConnectivityChanged>(),
          ),
        )
      ],
      child: const App(),
    );
  }
}
