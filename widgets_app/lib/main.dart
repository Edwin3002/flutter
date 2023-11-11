import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:widgets_app/config/app_theme.dart';
import 'package:widgets_app/providers/theme_provider.dart';
import 'package:widgets_app/routes/routes.dart';
import 'package:widgets_app/screens/home/home_screen.dart';

// @riverpod
// String helloWorld(HelloWorldRef ref) {
//   return 'Hello world';
// }

void main() {
  runApp(ProviderScope(child: Home()));
}

class Home extends ConsumerWidget {
  Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends StatefulWidget {
  int randomColor = 0;

  // @override
  // void initState() {
  //   Timer.periodic(const Duration(seconds: 3), (intervalTime) {
  //     setState(() {
  //       randomColor = Random().nextInt(8);
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bool isDarkMode = ref.watch(isDarkModeProvider);
    // final int randomColor = ref.watch(selectedColorProvider);
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp.router(
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
      // theme: AppTheme(selectdColor: randomColor, isDarkMode: isDarkMode)
      //     .getTheme(),
      theme: appTheme.getTheme()
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
