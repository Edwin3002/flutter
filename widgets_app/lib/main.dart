import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgets_app/config/app_theme.dart';
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectdColor: randomColor).getTheme(),
        home: HomeScreen()
        // Scaffold(
        //   body: Center(
        //       child: Column(
        //     // mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       FilledButton(
        //         onPressed: () {
        //           setState(() {
        //             randomColor = Random().nextInt(8);
        //           });
        //           // randomText == "Hola" ? randomText = "Bye" : "Hola";
        //         },
        //         child: const Text('Press'),
        //       ),
        //       Text("${randomColor % 2 == 0 ? "Par" : "Impar"} = $randomColor"),
        //       HomeScreen()
        //     ],
        //   )),
        // )
        );
  }
}
