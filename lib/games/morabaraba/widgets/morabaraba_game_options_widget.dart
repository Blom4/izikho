import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/games/common/models/player_model.dart';
import 'package:izikho/games/morabaraba/models/marabaraba_player_model.dart';

import '../../common/models/game_model.dart';
import '../../common/widgets/game_options_widgets.dart';
import '../models/morabaraba_cell_models.dart';
import '../models/morabaraba_game_model.dart';

class MorabarabaGameOptionsWidget extends StatelessWidget {
  const MorabarabaGameOptionsWidget({
    super.key,
    required this.onStartOfflineGame,
    required this.gameMode,
  });
  final void Function(MorabarabaGameOptions) onStartOfflineGame;
  final GameMode gameMode;

  @override
  Widget build(BuildContext context) {
    return switch (gameMode) {
      GameMode.offline => MorabarabaOfflineOptionsWidget(
          onStartGame: onStartOfflineGame,
        ),
      _ => const Text("Coming Soon"),
    };
  }
}

class MorabarabaOfflineOptionsWidget extends StatefulHookConsumerWidget {
  const MorabarabaOfflineOptionsWidget({
    super.key,
    required this.onStartGame,
  });

  final void Function(MorabarabaGameOptions) onStartGame;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MorabarabaOfflineOptionsState();
}

class _MorabarabaOfflineOptionsState
    extends ConsumerState<MorabarabaOfflineOptionsWidget> {
  late ValueNotifier<List<MorabarabaPlayerModel>> players;
  void startGame() {
    final gameOptions = MorabarabaGameOptions(
      gameType: GameType.morabaraba,
      gamePlayerType: GamePlayerType.morabaraba,
      gameMode: GameMode.offline,
      players: [
        MorabarabaPlayerModel(
          id: '0',
          username: 'Player 1',
          cowType: MorabarabaCowType.white,
          isTurn: true,
        ),
        MorabarabaPlayerModel(
          id: '1',
          username: 'Player 2',
          cowType: MorabarabaCowType.black,
        ),
      ],
    );
    widget.onStartGame(gameOptions);
  }

  @override
  Widget build(BuildContext context) {
    players = useState<List<MorabarabaPlayerModel>>([]);
    return GameOptionsContainerWidget(
      buttonLabel: 'Start Game',
      gameType: GameType.morabaraba,
      onStartGame: startGame,
      children: [
        GameOptionCardWidget(
          icon: Icons.seven_k_outlined,
          title: 'Players',
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Player 1"),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left),
                    ),
                    const Text("Person"),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
