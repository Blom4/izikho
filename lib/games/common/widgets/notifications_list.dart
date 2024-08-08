import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/game_notification.dart';
import '../providers/game_provider.dart';
import '../screens/waiting_screen.dart';

class NotificationList extends StatefulHookConsumerWidget {
  const NotificationList({
    required this.notifications,
    super.key,
  });
  final List<GameNotificationModel> notifications;

  @override
  ConsumerState<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends ConsumerState<NotificationList> {
  Future<void> joinGame(GameNotificationModel notification) async {
    try {
      await ref.read(gameProvider().notifier).joinGame(notification.gameId);
      if (mounted) {
        context.goNamed(WaitingScreen.routename, extra: notification.gameId);
      }
    } on PostgrestException catch (e) {
      if (mounted) {
        context.showSnackBar(e.message, isError: true);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString(), isError: true);
      }
    }
  }

  Future<void> rejectGame() async {}

  @override
  Widget build(BuildContext context) {
    return widget.notifications.isEmpty
        ? const Center(child: Text("No notifications Available"))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.notifications.length,
            itemBuilder: (context, index) {
              final notification = widget.notifications[index];
              return ListTile(
                onTap: () async {
                  final accepted = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Accept the Invitation'),
                        content: Text(
                            "${notification.senderName} ${notification.message}"),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text("Reject"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text("Accept"),
                          ),
                        ],
                      );
                    },
                  );
                  if (accepted != null) {
                    accepted
                        ? await joinGame(notification)
                        : await rejectGame();
                  }
                },
                title: Text(
                  notification.senderName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Text(notification.message),
              );
            },
          );
  }
}
