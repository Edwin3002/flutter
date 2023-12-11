// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notify/domain/entities/push_message.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:notifications_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  static Future<void> initFirebaseNotifications() async {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
  }

  void requestPermission() async {
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: true,
    //   provisional: false,
    //   sound: true,
    // );
    // add(NotificationStatusChanged(settings.authorizationStatus));
    // settings.authorizationStatus;
  }
}
