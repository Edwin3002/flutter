import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/app_theme.dart';

final colorListProvider = StateProvider((ref) => <Color>[
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.deepPurple,
      Colors.orange,
      Colors.pink,
      Color.fromRGBO(55, 112, 123, 1),
    ]);

final isDarkModeProvider = StateProvider((ref) => true);

final selectedColorProvider = StateProvider((ref) => 0);

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}
