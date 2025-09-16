import 'package:flutter/material.dart';
import 'package:health_reminder/add_pill_screen.dart';
import 'package:health_reminder/home_screen.dart';

void main() {
  runApp(const PillPallApp());
}

class PillPallApp extends StatelessWidget {
  const PillPallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const AddPillScreen());
  }
}
