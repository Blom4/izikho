import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/providers/supabase_provider.dart';
import '../models/game_notification.dart';

part 'game_notifications_provider.g.dart';

@riverpod
class GameNotifications extends _$GameNotifications {
  @override
  Stream<List<GameNotificationModel>> build() {
    final client = ref.watch(supabaseProvider);
    return client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('viewed', false)
        .asyncMap((event) =>
            event.map((e) => GameNotificationModel.fromMap(e)).toList());
  }

  Future<void> viewNotification(GameNotificationModel notificationModel) async {
    final client = ref.read(supabaseProvider);
    await client
        .from('notifications')
        .update({'viewed': true})
        .eq('id', notificationModel.id!)
        .select();
  }
}
