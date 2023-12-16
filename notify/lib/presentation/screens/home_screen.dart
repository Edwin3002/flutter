import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notify/domain/entities/push_message.dart';
import 'package:notify/presentation/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: context.select(
                (NotificationsBloc bloc) => Text("${bloc.state.status}")),
            actions: [
              IconButton(
                  onPressed: () =>
                      {context.read<NotificationsBloc>().requestPermission()},
                  icon: const Icon(Icons.settings))
            ]),
        body: const _HomeView());
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<PushMessage> notifications =
        context.watch<NotificationsBloc>().state.notifications;

    // List<PushMessage> notifications = [
    //   PushMessage(
    //       messageId: "1", title: "titulo", body: "", sentDate: DateTime.now()),
    //   PushMessage(
    //       messageId: "1", title: "titulo", body: "", sentDate: DateTime.now())
    // ];
    return ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notify = notifications[index];
          return ListTile(
            title: Text(notify.title),
            subtitle: Text(notify.body),
            leading: notify.imageUrl != null
                ? Image.network(notify.imageUrl!)
                : null,
                onTap: () => context.push("/msg-details/${notify.messageId}"),
            tileColor: colors[index % 2 == 0 ? 0 : 1],
          );
        });
  }
}

List<Color> colors = [Colors.green, Colors.purple];
