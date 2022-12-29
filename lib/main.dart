import 'package:flutter/material.dart';
import 'package:offline_first_workflow/src/core/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
