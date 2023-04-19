import 'package:flutter/material.dart';
import './pages/Starter_page.dart';
import './pages/Login_page.dart';
import './pages/MainHome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const StarterPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainHome(),
      },
    );
  }
}
