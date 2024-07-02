import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/chat/widgets/room_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../providers/chat_room_provider.dart';
import 'chat_messages_screen.dart';
import 'chat_users_screen.dart';

class ChatRoomsScreen extends StatefulHookConsumerWidget {
  const ChatRoomsScreen({super.key});
  static const String routename = "chat_rooms_screen";

  @override
  ConsumerState<ChatRoomsScreen> createState() => _RoomsPageState();
}

class _RoomsPageState extends ConsumerState<ChatRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    final chatRoom = ref.watch(chatRoomProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Rooms'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_comment),
        onPressed: () => context.goNamed(ChatUsersScreen.routename),
      ),
      body: switch (chatRoom) {
        AsyncData(:final value) => value.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No rooms'),
              )
            : ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final room = value[index];
                  return ListTile(
                    key: ValueKey(room.id),
                    leading: RoomAvatar(room: room),
                    title: Text(room.name ?? ''),
                    subtitle: Text(
                        '${timeago.format(DateTime.now().subtract(Duration(milliseconds: DateTime.now().millisecondsSinceEpoch - (room.updatedAt ?? 0))), locale: 'en_short')} ${room.lastMessages != null && room.lastMessages!.isNotEmpty && room.lastMessages!.first is types.TextMessage ? (room.lastMessages!.first as types.TextMessage).text : ''}'),
                    onTap: () {
                      context.goNamed(
                        ChatMessagesScreen.routename,
                        extra: room,
                      );
                    },
                  );
                },
              ),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
