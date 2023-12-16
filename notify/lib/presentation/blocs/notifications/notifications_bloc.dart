import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:log_print/log_print.dart';
import 'package:notify/config/local_notifications/local_notifications.dart';
import 'package:notify/domain/entities/push_message.dart';
import 'package:notify/firebase_options.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  int localNotifyID = 0;

  final Future<void> Function()? requestLocalnotifictionPermissions;
  final void Function(
      {required int id,
      String? title,
      String? body,
      String? data})? showLocalNotification;

  NotificationsBloc({
    this.requestLocalnotifictionPermissions,
    this.showLocalNotification,
  }) : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushNotificationReceived);
    _initialStatusCheck();
    _onForegroundMessage();
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFirebaseCloudMessasingToken();
  }

  void _onPushNotificationReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state
        .copyWith(notifications: [event.pushMessage, ...state.notifications]));
  }

  static Future<void> initFirebaseNotifications() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFirebaseCloudMessasingToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    LogPrint("token $token", type: LogPrintType.info);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(":", "").replaceAll("%", "") ?? "",
        title: message.notification!.title ?? "",
        body: message.notification!.body ?? "",
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification!.android?.imageUrl
            : message.notification!.apple?.imageUrl);
    if (showLocalNotification != null) {
      showLocalNotification!(
          id: localNotifyID++,
          body: notification.body,
          data: notification.messageId,
          title: notification.title);
    }
    add(NotificationReceived(notification));
    // NotificationsState(notifications: );
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    if (requestLocalnotifictionPermissions != null) {
      await requestLocalnotifictionPermissions!();
    }
    // await LocalNotifications.requestPermissionLocalNotifications();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String pushMsgId) {
    final exist =
        state.notifications.any((notify) => notify.messageId == pushMsgId);
    if (!exist) return null;
    return state.notifications
        .firstWhere((notify) => notify.messageId == pushMsgId);
  }
}
