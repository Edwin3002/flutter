import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/config/routes/router.dart';
import 'package:notify/config/theme/app_theme.dart';
import 'package:notify/presentation/blocs/notifications/notifications_bloc.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await NotificationsBloc.initFirebaseNotifications();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => NotificationsBloc(),
    )
  ], child: const MainApp()));
  // runApp( const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: Apptheme().getTheme(),
      routerConfig: appRouter,
      // home: const Scaffold(
      //   body: Center(
      //     child: Text('Hello World! sii'),
      //   ),
      // ),
    );
  }
}
