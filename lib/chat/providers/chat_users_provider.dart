import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/model/profile_model.dart';
part 'chat_users_provider.g.dart';

@riverpod
Stream<List<ProfileModel>> chatUsers(ChatUsersRef ref) {
  return SupabaseChatCore.instance.users().asyncMap(
        (event) => event
            .map(
              (e) => ProfileModel.fromUser(e),
            )
            .toList(),
      );
}
