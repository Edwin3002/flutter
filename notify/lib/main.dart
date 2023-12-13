import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/config/routes/router.dart';
import 'package:notify/config/theme/app_theme.dart';
import 'package:notify/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:log_print/log_print.dart';
import 'package:log_print/log_print_config.dart';
void main() async {
 setLogPrintConfig(LogPrintConfig(colorful: true, debugMode: true));
 LogPrint("This is Info Message", type: LogPrintType.info);
   WidgetsFlutterBinding.ensureInitialized();
   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler );
  await NotificationsBloc.initFirebaseNotifications();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => NotificationsBloc(),
    )
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: Apptheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
