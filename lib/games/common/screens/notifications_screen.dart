import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/game_notifications_provider.dart';
import '../widgets/notifications_list.dart';

class NotificationsScreen extends StatefulHookConsumerWidget {
  static const String routename = 'notifications_screen';
  const NotificationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncGameNotifications = ref.watch(gameNotificationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: switch (asyncGameNotifications) {
          AsyncData(:final value) => NotificationList(notifications: value),
          AsyncError(:final error) => Center(child: Text(error.toString())),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
