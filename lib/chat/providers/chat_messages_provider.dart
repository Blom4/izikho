import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chat_messages_provider.g.dart';

@riverpod
Stream<List<types.Message>> chatMessages(
    ChatMessagesRef ref, SupabaseChatController controller) {
  return controller.messages;
}