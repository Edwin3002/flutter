import 'package:flutter/material.dart';
import 'package:form_app/config/app_theme.dart';
import 'package:form_app/routes/app_router.dart';

void main() {
  // runApp(const ProviderScope(child: MainApp()));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
    routerConfig: appRouter,
    debugShowCheckedModeBanner: false,
    theme: Apptheme().getTheme(),
    
      // home: Scaffold( el home no es necesario por lo q esta implementa lo de rutas
      //   body: Center(
      //       child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //     Text('Form app'),
      //     Text(Platform.isAndroid ? "android" : "ios"),
      //   ])),
      // ),
    );
  }
}
