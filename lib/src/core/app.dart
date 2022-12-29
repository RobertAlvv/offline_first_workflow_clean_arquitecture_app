import 'package:flutter/material.dart';
import 'package:offline_first_workflow/src/features/products/presentation/screens/currency_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrencyScreen(),
    );
  }
}
