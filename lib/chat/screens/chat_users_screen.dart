import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/chat/widgets/user_avatar.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/chat_room_provider.dart';
import '../providers/chat_users_provider.dart';
import '../utils/colors.dart';
import 'chat_messages_screen.dart';

class ChatUsersScreen extends StatefulHookConsumerWidget {
  const ChatUsersScreen({super.key});
  static const String routename = 'chat_users_screen';

  @override
  ConsumerState<ChatUsersScreen> createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends ConsumerState<ChatUsersScreen> {
  void _createRoom(types.User otherUser) async {
    try {
      final room =
          await ref.read(chatRoomProvider.notifier).createRoom(otherUser);
      if (mounted) {
        context.goNamed(ChatMessagesScreen.routename, extra: room);
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

  @override
  Widget build(BuildContext context) {
    final chatUsers = ref.watch(chatUsersProvider);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: const Text('Users'),
      ),
      body: switch (chatUsers) {
        AsyncData(:final value) => value.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No users'),
              )
            : ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final user = value[index];
                  return ListTile(
                    leading: UserAvatar(user: user),
                    title: Text(getUserName(user)),
                    onTap: () => _createRoom(user),
                  );
                },
              ),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
