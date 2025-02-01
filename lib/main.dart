import 'package:basic_app/ui/core/theme/theme_data.dart';
import 'package:basic_app/ui/feature/home/widgets/homePage/home_page.dart';
import 'package:basic_app/ui/feature/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const LoginPage(),
    );
  }
}
