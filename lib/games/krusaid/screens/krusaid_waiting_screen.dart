import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/krusaid_player_provider.dart';
import '../providers/krusaid_room_provider.dart';

class KrusaidWaitingScreen extends ConsumerWidget {
  const KrusaidWaitingScreen({super.key});
  static const routename = 'krusaid-waiting-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomProvider = ref.watch(krusaidRoomProvider);
    final playerProvider = ref.watch(krusaidPlayerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waiting Screen"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Room ID : ${roomProvider.id}"),
          Text("You : ${playerProvider.username}"),
          const SizedBox(height: 10),
          const Text("PLAYERS"),
          for (var player in roomProvider.players) Text(" - ${player.username}")
        ],
      ),
    );
  }
}
