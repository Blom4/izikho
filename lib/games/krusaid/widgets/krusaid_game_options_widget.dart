import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:izikho/games/krusaid/models/krusaid_player_model.dart';

import '../../common/models/game_model.dart';
import '../../common/models/player_model.dart';
import '../../common/widgets/game_options_widgets.dart';
import '../models/krusaid_game_model.dart';

class KrusaidGameOptionsWidget extends StatelessWidget {
  const KrusaidGameOptionsWidget({
    super.key,
    required this.onStartOfflineGame,
    required this.onStartOnlineGame,
    required this.gameMode,
  });
  final Future<void> Function(KrusaidGameOptions) onStartOnlineGame;
  final void Function(KrusaidGameOptions) onStartOfflineGame;
  final GameMode gameMode;

  @override
  Widget build(BuildContext context) {
    return switch (gameMode) {
      GameMode.online => KrusaidOnlineOptionsWidget(
          onStartGame: onStartOnlineGame,
        ),
      _ => const Text('Coming Soon'),
    };
  }
}

class KrusaidOnlineOptionsWidget extends StatefulHookConsumerWidget {
  const KrusaidOnlineOptionsWidget({
    super.key,
    required this.onStartGame,
  });
  final Future<void> Function(KrusaidGameOptions) onStartGame;

  @override
  ConsumerState<KrusaidOnlineOptionsWidget> createState() =>
      _KrusaidOnlineOptionsWidgetState();
}

class _KrusaidOnlineOptionsWidgetState
    extends ConsumerState<KrusaidOnlineOptionsWidget> {
  late ValueNotifier<List<KrusaidPlayerModel>> selectedPlayers;
  late ValueNotifier<double> servedCards;
  late ValueNotifier<bool> loading;

  Future<void> searchOnlinePlayer(List<KrusaidPlayerModel> players) async {
    if ((players.length + 1) < GameType.krusaid.maxPlayers) {
      selectedPlayers.value = players;
    } else {
      if (mounted) {
        context.showSnackBar(
          'You Can Only invite ${GameType.morabaraba.maxPlayers - 1} player(s)',
          isError: true,
        );
      }
    }
  }

  Future<void> startGame() async {
    final gameOptions = KrusaidGameOptions(
      gameType: GameType.krusaid,
      gamePlayerType: GamePlayerType.krusaid,
      gameMode: GameMode.online,
      players: selectedPlayers.value,
      servedCards: servedCards.value,
    );
    if (selectedPlayers.value.isNotEmpty) {
      loading.value = true;
      await widget.onStartGame(gameOptions);
      loading.value = false;
    } else {
      context.showSnackBar("Please Invite Atleast One Player");
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedPlayers = useState<List<KrusaidPlayerModel>>([]);
    servedCards = useState<double>(6);
    loading = useState<bool>(false);
    return GameOptionsContainerWidget(
      buttonLabel: loading.value ? 'Starting' : 'Start Game',
      gameType: GameType.krusaid,
      onStartGame: loading.value ? null : startGame,
      children: [
        GameOptionCardWidget(
          icon: Icons.seven_k_outlined,
          title: 'Cards To Serve',
          children: [
            Row(
              children: [
                Text("${servedCards.value}"),
                Expanded(
                  child: Slider(
                    label: 'Cards: ${servedCards.value}',
                    max: 8,
                    min: 4,
                    divisions: 4,
                    value: servedCards.value,
                    onChanged: (value) => servedCards.value = value,
                  ),
                ),
              ],
            ),
          ],
        ),
        PlayersGameOptionCardWidget<KrusaidPlayerModel>(
          onSearchOnlinePlayer: searchOnlinePlayer,
          playerType: GamePlayerType.krusaid,
        ),
      ],
    );
  }
}
