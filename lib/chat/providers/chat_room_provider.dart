import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:supabase_flutter/supabase_flutter.dart';
part 'chat_room_provider.g.dart';

@riverpod
class ChatRoom extends _$ChatRoom {
  @override
  Stream<List<types.Room>> build() {
    return SupabaseChatCore.instance.rooms() ;
  }

  Future<types.Room> createRoom(types.User otherUser) async{
    try{
     return await SupabaseChatCore.instance.createRoom(otherUser);
    } on PostgrestException catch(e){
      throw PostgrestException(message: e.message,code: e.code);
    }catch(e){
      throw Exception(e);
    }
  }
}
