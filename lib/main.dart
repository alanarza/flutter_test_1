import 'package:flutter/material.dart';
import 'package:test_2/theme/dark_mode.dart';
import 'package:test_2/theme/light_mode.dart';
import 'package:test_2/view/auth/login_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Sounds',
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
