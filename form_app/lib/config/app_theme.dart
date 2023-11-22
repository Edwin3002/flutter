import 'package:flutter/material.dart';

class Apptheme {
  ThemeData getTheme() {
    const seedColor = Colors.deepPurple;
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        listTileTheme: const ListTileThemeData(iconColor: seedColor));
  }
}
