import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/providers/supabase_provider.dart';
import '../models/game_notification.dart';

part 'game_notifications_provider.g.dart';

@riverpod
Stream<List<GameNotificationModel>> gameNotifications(
    GameNotificationsRef ref) {
  final client = ref.watch(supabaseProvider);
  return client.from('notifications').stream(primaryKey: ['id']).asyncMap(
      (event) => event.map((e) => GameNotificationModel.fromMap(e)).toList());
}
