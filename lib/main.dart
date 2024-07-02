import 'package:flutter/material.dart';
import 'package:led_app/page/HomePage.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData _theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
    useMaterial3: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LED',
      theme: _theme,
      home: HomePage(callback: _changeTheme),
    );
  }

  void _changeTheme(Color color) {
    setState(() {
      _theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        useMaterial3: true,
      );
    });
  }
}
