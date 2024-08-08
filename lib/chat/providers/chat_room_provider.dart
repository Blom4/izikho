import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/model/profile_model.dart';
part 'chat_room_provider.g.dart';

@riverpod
class ChatRoom extends _$ChatRoom {
  @override
  Stream<List<types.Room>> build() {
    final rooms = SupabaseChatCore.instance.rooms();
    final userId = SupabaseChatCore.instance.supabaseUser!.id;
    return rooms.asyncMap(
      (event) => event.map(
        (room) {
          if (room.type! == types.RoomType.direct) {
            return room.copyWith(
              name: ProfileModel.fromUser(
                  room.users.firstWhere((e) => e.id != userId)).username,
            );
          }
          return room;
        },
      ).toList(),
    );
  }

  Future<types.Room> createRoom(types.User otherUser) async {
    try {
      return await SupabaseChatCore.instance.createRoom(otherUser);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message, code: e.code);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<types.Room> createGroupRoom(
      String name, List<types.User> users) async {
    try {
      return await SupabaseChatCore.instance
          .createGroupRoom(name: name, users: users);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message, code: e.code);
    } catch (e) {
      throw Exception(e);
    }
  }
}
