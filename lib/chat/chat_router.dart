import 'package:go_router/go_router.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'screens/chat_messages_screen.dart';
import 'screens/chat_rooms_screen.dart';
import 'screens/chat_users_screen.dart';

class ChatRouter {
  static final route = GoRoute(
    path: 'chat/rooms',
    name: ChatRoomsScreen.routename,
    builder: (context, state) => const ChatRoomsScreen(),
    routes: [
      GoRoute(
        path: "chat/messages",
        name: ChatMessagesScreen.routename,
        builder: (context, state) => ChatMessagesScreen(
          room: state.extra! as types.Room,
        ),
      ),
      GoRoute(
        path: "chat/users",
        name: ChatUsersScreen.routename,
        builder: (context, state) => const ChatUsersScreen(),
      ),
    ],
  );
}
