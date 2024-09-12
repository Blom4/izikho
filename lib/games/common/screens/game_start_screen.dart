import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../krusaid/widgets/krusaid_game_options_widget.dart';
import '../../morabaraba/widgets/morabaraba_game_options_widget.dart';
import '../models/game_model.dart';
import '../providers/online_game_provider.dart';
import '../widgets/game_options_widgets.dart';
import '../widgets/game_search_widget.dart';
import 'waiting_screen.dart';

class GameStartScreen extends StatefulHookConsumerWidget {
  const GameStartScreen({super.key});

  static const routename = 'game_start_screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GameStartScreenState();
}

class _GameStartScreenState extends ConsumerState<GameStartScreen> {
  late ValueNotifier<GameType?> selectedGame;
  late ValueNotifier<GameMode?> selectedMode;
  Future<void> startOnlineGame(GameOptions gameOptions) async {
    try {
      if (gameOptions.gameMode == GameMode.online) {
        final gameId = await ref
            .read(onlineGameProvider().notifier)
            .createGame(gameOptions);
        if (mounted) {
          context.goNamed(WaitingScreen.routename, extra: gameId);
        }
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

  void startOffineGame(GameOptions gameOptions) {
    //ref.read(offlineGameProvider).createGame(gameOptions);
    context.goNamed(gameOptions.gameType.route, extra: gameOptions);
  }

  Future<void> selectGame() async {
    var results = await showModalBottomSheet<GameType?>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return GameSearchWidget(
          hintText: '',
          onGameSelected: (item) {
            Navigator.of(context).pop(item);
          },
        );
      },
    );
    if (results != null) {
      selectedGame.value = results;
    }
  }

  Future<void> selectMode() async {
    var results = await showModalBottomSheet<GameMode?>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) {
        return ModeSearchWidget(
          hintText: '',
          onModeSelected: (item) {
            Navigator.of(context).pop(item);
          },
        );
      },
    );
    if (results != null) {
      selectedMode.value = results;
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedGame = useState<GameType?>(null);
    selectedMode = useState<GameMode?>(null);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Game"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              GameOptionTileWidget(
                icon: Icons.gamepad,
                title: "Select Game",
                subtitle: selectedGame.value != null
                    ? Text(
                        selectedGame.value!.name,
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    : null,
                onTap: selectGame,
              ),
              const SizedBox(height: 10),
              GameOptionTileWidget(
                icon: Icons.wifi_off,
                title: "Select Mode",
                subtitle: selectedMode.value != null
                    ? Text(
                        selectedMode.value!.name,
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    : null,
                onTap: selectMode,
              ),
              const SizedBox(height: 10),
              if (selectedGame.value != null && selectedMode.value != null)
                switch (selectedGame.value) {
                  GameType.krusaid => KrusaidGameOptionsWidget(
                      gameMode: selectedMode.value!,
                      onStartOnlineGame: startOnlineGame,
                      onStartOfflineGame: startOffineGame,
                    ),
                  GameType.morabaraba => MorabarabaGameOptionsWidget(
                      gameMode: selectedMode.value!,
                      onStartOfflineGame: startOffineGame,
                    ),
                  _ => const Text('Coming Soon'),
                },
            ],
          ),
        ),
      ),
    );
  }
}
