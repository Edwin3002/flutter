import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgets_app/config/app_theme.dart';
import 'package:widgets_app/routes/routes.dart';
import 'package:widgets_app/screens/home/home_screen.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int randomColor = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (intervalTime) {
      setState(() {
        randomColor = Random().nextInt(8);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectdColor: randomColor).getTheme(),
      // home: const HomeScreen(),
      // routes: <String, WidgetBuilder>{
      // routes.map((e) => '/home': (BuildContext context) => const HomeScreen() // no funciono
      // '/home': (BuildContext context) => const HomeScreen(),
      // '/cards': (BuildContext context) => const CardScreen(),
      // '/btns': (BuildContext context) => const ButtonsScreen(),
      // },
    );
  }
}

List routes = [
  {"linkName": "home", Widget: const HomeScreen()}
];
