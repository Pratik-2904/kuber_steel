import 'package:flutter/material.dart';
import 'package:kuber_steel/pages/home_with_overlay.dart';
import 'package:kuber_steel/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: AppTheme.scaffoldBackgroundColor,
      debugShowCheckedModeBanner: false,
      home: HomeWithOverlay(),
    );
  }
}
