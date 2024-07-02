
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chat_users_provider.g.dart';

@riverpod
class ChatUsers extends _$ChatUsers {
  @override
  Stream<List<types.User>> build() {
    return SupabaseChatCore.instance.users() ;
  }
}
