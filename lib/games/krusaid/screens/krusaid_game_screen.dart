import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/responsive/responsive.dart';
import '../providers/krusaid_room_provider.dart';
import '../widgets/custom_bottom_appbar.dart';
import '../widgets/player_cards_widget.dart';
import '../widgets/players_widget.dart';
import '../widgets/playground_widget.dart';

class KrusaidGameScreen extends HookConsumerWidget {
  const KrusaidGameScreen({super.key});

  static const String routename = "Krusaid-game-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomProvider = ref.watch(krusaidRoomProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Krusaid",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            )
          ],
        ),
        bottomNavigationBar:
            !Responsive.isMobile(context) ? null : const CustomBottomAppBar(),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PlayersWidget(players: roomProvider.players),
                  Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: PlayGroundWidget(),
                        ),
                        Expanded(
                          flex: Responsive.isMobile(context) ? 3 : 4,
                          child: const PlayerCardsWidget(),
                        ),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context)) const CustomBottomAppBar()
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
