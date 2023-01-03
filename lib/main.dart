import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:offline_first_workflow/src/core/app_bloc.dart';
import 'src/core/injection_dependency/injection_container.dart'
    as dependecy_injector;

void main() async {
  await dotenv.load(fileName: ".env");
  await dependecy_injector.init();
  runApp(const AppBloc());
}
