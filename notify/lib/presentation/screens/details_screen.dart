import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/domain/entities/push_message.dart';
import 'package:notify/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String pushMsgId;
  const DetailsScreen({super.key, required this.pushMsgId});

  @override
  Widget build(BuildContext context) {
    final PushMessage? msg =
        context.watch<NotificationsBloc>().getMessageById(pushMsgId);

    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: msg != null
          ? _DetailsView(
              message: msg,
            )
          : const Center(child: Text("Notify no exits`")),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;

  const _DetailsView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Center(
        child: Column(
          children: [
            if (message.imageUrl != null) Image.network(message.imageUrl!),
            const SizedBox(
              height: 30,
            ),
            Text(message.title, style: textStyles.titleLarge),
            Text(message.body, style: textStyles.titleSmall),
            const SizedBox(
              height: 30,
            ),
            Text(message.data.toString()),
          ],
        ),
      ),
    );
  }
}
