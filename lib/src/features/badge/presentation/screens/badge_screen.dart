import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/widgets/badget_card.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
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
