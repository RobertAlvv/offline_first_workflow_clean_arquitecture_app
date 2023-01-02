import 'package:utils_material/utils_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/screens/badge_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ScaffoldMessengerLP.messengerKey,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color.fromARGB(255, 37, 37, 37),
        ),
        fontFamily: GoogleFonts.robotoSlab().fontFamily,
        scaffoldBackgroundColor: const Color.fromARGB(255, 37, 37, 37),
      ),
      home: const BadgeScreen(),
    );
  }
}
