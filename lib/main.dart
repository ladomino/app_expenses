import 'package:app_expenses/screens/expenses.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _createTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Times New Roman', 
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.light(useMaterial3: true),
      theme: _createTheme(Brightness.light),
      darkTheme: _createTheme(Brightness.dark),
      themeMode: ThemeMode.system, // Use system theme mode
      home: Expenses(),
    );
  }
}
