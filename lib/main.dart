import 'package:flutter/material.dart';
import './pages/Starter_page.dart';
import './pages/Login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Drive sound',
        // home: StarterPage(),
        home: LoginPage());
  }
}
