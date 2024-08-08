import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/widgets/section_header_widget.dart';
import '../providers/game_notifications_provider.dart';
import 'notifications_list.dart';

class RecentNotifications extends ConsumerWidget {
  const RecentNotifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncGameNotifications = ref.watch(gameNotificationsProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: switch (asyncGameNotifications) {
        AsyncData(:final value) => value.isEmpty
            ? Container()
            : Column(
                children: [
                  SectionHeaderWidget(
                    title: "Recent Notifications",
                    onPressed: () {},
                  ),
                  NotificationList(notifications: value),
                ],
              ),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
