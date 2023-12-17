import 'package:flutter/material.dart';
import 'package:log_print/log_print.dart';
import 'package:log_print/log_print_config.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Enviroment.initEnviroment();
  setLogPrintConfig(LogPrintConfig(colorful: true, debugMode: true));
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
