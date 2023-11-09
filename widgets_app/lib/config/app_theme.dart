import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectdColor;
  AppTheme({this.selectdColor = 0})
      : assert(selectdColor >= 0, "select color must be greater than 0"),
        assert(selectdColor < colorList.length, "select color must be less or equal than ${colorList.length - 1}");

  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: colorList[selectdColor]);
}
