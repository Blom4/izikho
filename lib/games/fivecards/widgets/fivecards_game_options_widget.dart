import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';

import '../../common/models/game_model.dart';
import '../../common/models/player_model.dart';
import '../../common/widgets/game_options_widgets.dart';
import '../models/fivecards_game_model.dart';
import '../models/fivecards_player_model.dart';

class FivecardsGameOptionsWidget extends StatelessWidget {
  const FivecardsGameOptionsWidget({
    super.key,
    required this.onStartOfflineGame,
    required this.onStartOnlineGame,
    required this.gameMode,
  });
  final Future<void> Function(FivecardsGameOptions) onStartOnlineGame;
  final void Function(FivecardsGameOptions) onStartOfflineGame;
  final GameMode gameMode;

  @override
  Widget build(BuildContext context) {
    return switch (gameMode) {
      GameMode.online => FivecardsOnlineOptionsWidget(
          onStartGame: onStartOnlineGame,
        ),
      _ => const Text('Coming Soon'),
    };
  }
}

class FivecardsOnlineOptionsWidget extends StatefulHookConsumerWidget {
  const FivecardsOnlineOptionsWidget({
    super.key,
    required this.onStartGame,
  });
  final Future<void> Function(FivecardsGameOptions) onStartGame;

  @override
  ConsumerState<FivecardsOnlineOptionsWidget> createState() =>
      _FivecardsOnlineOptionsWidgetState();
}

class _FivecardsOnlineOptionsWidgetState
    extends ConsumerState<FivecardsOnlineOptionsWidget> {
  late ValueNotifier<List<FivecardsPlayerModel>> selectedPlayers;
  late ValueNotifier<bool> loading;

  Future<void> searchOnlinePlayer(List<FivecardsPlayerModel> players) async {
    if ((players.length + 1) < GameType.fivecards.maxPlayers) {
      selectedPlayers.value = players;
    } else {
      if (mounted) {
        context.showSnackBar(
          'You Can Only invite ${GameType.fivecards.maxPlayers - 1} player(s)',
          isError: true,
        );
      }
    }
  }

  Future<void> startGame() async {
    final gameOptions = FivecardsGameOptions(
      gameType: GameType.fivecards,
      gamePlayerType: GamePlayerType.fivecards,
      gameMode: GameMode.online,
      players: selectedPlayers.value,
    );
    if (selectedPlayers.value.isNotEmpty) {
      loading.value = true;
      await widget.onStartGame(gameOptions);
      loading.value = false;
    } else {
      context.showSnackBar("Please Invite At least One Player");
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedPlayers = useState<List<FivecardsPlayerModel>>([]);
    loading = useState<bool>(false);
    return GameOptionsContainerWidget(
      buttonLabel: loading.value ? 'Starting' : 'Start Game',
      gameType: GameType.fivecards,
      onStartGame: loading.value ? null : startGame,
      children: [
        GamePlayersOptionCardWidget<FivecardsPlayerModel>(
          onSearchOnlinePlayer: searchOnlinePlayer,
          playerType: GamePlayerType.fivecards,
        ),
      ],
    );
  }
}
