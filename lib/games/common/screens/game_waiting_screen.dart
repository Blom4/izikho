import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/games/common/providers/game_online_provider.dart';

class GameWaitingScreen extends StatefulHookConsumerWidget {
  const GameWaitingScreen({
    super.key,
    required this.channel,
  });
  static const routename = 'game_waiting_screen';
  final String channel;

  @override
  ConsumerState<GameWaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<GameWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(gameOnlineProvider(widget.channel), (_, next) {
      if (next.hasValue && next.value!.allJoined) {
        context.goNamed(next.value!.gameType.route, extra: next.value!);
      }
    });
    final asyncGame = ref.watch(gameOnlineProvider(widget.channel));
    return Scaffold(
      appBar: AppBar(title: const Text("Waiting Screen")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: switch (asyncGame) {
          AsyncData(:final value) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Game : ${value.gameType.name}"),
                Text("You : ${value.currentPlayer.username}"),
                const SizedBox(height: 10),
                const Text("PLAYERS"),
                for (var player in value.otherPlayers)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(" - ${player.username}"),
                      Text(" - ${player.joined ? "Joined" : ""}"),
                    ],
                  )
              ],
            ),
          AsyncError(:final error) => Center(child: Text(error.toString())),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
