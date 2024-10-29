import 'package:flutter/material.dart';
import 'package:kuber_steel/pages/customer_selection/customer_details.dart';
import 'package:kuber_steel/pages/customer_selection/customer_selection_screen.dart';
import 'package:kuber_steel/pages/home_page.dart';
import 'package:kuber_steel/pages/home_with_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      // home: HomeWithOverlay(),
      home: CustomerDetailsPage(),
    );
  }
}
