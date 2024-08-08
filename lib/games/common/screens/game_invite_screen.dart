// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:izikho/games/common/models/player_model.dart';
import 'package:izikho/games/common/providers/game_provider.dart';
import 'package:izikho/games/common/screens/waiting_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/model/profile_model.dart';
import '../../../chat/providers/chat_users_provider.dart';
import '../../../common/widgets/my_button.dart';
import '../models/game_model.dart';
import '../models/game_options.dart';
import '../widgets/game_search_widget.dart';
import '../widgets/player_search_widget.dart';

class GameInviteScreen extends StatefulHookConsumerWidget {
  static const routename = 'game_invite_screen';
  const GameInviteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GameInviteScreenState();
}

class _GameInviteScreenState extends ConsumerState<GameInviteScreen> {
  Future<void> invite(
    GameType gameType,
    List<ProfileModel> recipients,
    String message,
  ) async {
    try {
      final gameId = await ref.read(gameProvider().notifier).createGame(
            gameType,
            recipients.map((e) => PlayerModel.fromProfile(e)).toList(),
            message,
          );
      if (mounted) {
        context.goNamed(WaitingScreen.routename, extra: gameId);
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
    final asyncPlayers = ref.watch(chatUsersProvider);

    final selectedGame = useState<GameType?>(null);
    final selectedPlayers = useState<List<ProfileModel>>([]);
    final isSinglePlayer = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invite Players"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                tileColor: Theme.of(context).colorScheme.onSecondary,
                title: Text(
                  "Select Game",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                subtitle: selectedGame.value == null
                    ? null
                    : Text(selectedGame.value!.name),
                trailing: const Icon(
                  Icons.arrow_drop_down,
                  size: 50,
                ),
                onTap: () async {
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
                },
              ),
              const SizedBox(height: 20),
              //Number of players
              if (selectedGame.value != null)
                SwitchListTile(
                  tileColor: Theme.of(context).colorScheme.onSecondary,
                  value: isSinglePlayer.value,
                  onChanged: (value) => isSinglePlayer.value = value,
                  title: Text(
                    "Single Player",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              const SizedBox(height: 20),
              if (isSinglePlayer.value)
                //game level option
                ListTile(
                  tileColor: Theme.of(context).colorScheme.onSecondary,
                  title: Text(
                    "Level",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  trailing: ToggleButtons(
                    onPressed: (value) {},
                    isSelected: const [false, true, false],
                    children: GameLevel.values
                        .map(
                          (e) => Text(
                            e.name.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        )
                        .toList(),
                  ),
                ),
              const SizedBox(height: 10),
              //users invited
              if (selectedGame.value != null)
                Column(
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).colorScheme.onSecondary,
                      title: Text(
                        "Add Player",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      trailing: const Icon(
                        Icons.add_circle,
                        size: 30,
                      ),
                      onTap: () async {
                        var results = await showModalBottomSheet<ProfileModel?>(
                          context: context,
                          useSafeArea: true,
                          showDragHandle: true,
                          builder: (context) {
                            return asyncPlayers.when(
                              data: (data) {
                                return PlayerSearchWidget(
                                  profiles: data,
                                  hintText: 'Search Players',
                                  onPlayerSelected: (item) {
                                    Navigator.of(context).pop(item);
                                  },
                                );
                              },
                              error: (error, stackTrace) =>
                                  Center(child: Text(error.toString())),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                            );
                          },
                        );
                        if (results != null) {
                          if ((selectedPlayers.value.length + 1) <
                              selectedGame.value!.maxPlayers) {
                            selectedPlayers.value = <ProfileModel>{
                              ...selectedPlayers.value,
                              results
                            }.toList();
                          } else {
                            if (mounted) {
                              context.showSnackBar(
                                'You Can Only invite ${selectedGame.value!.maxPlayers - 1} player(s)',
                                isError: true,
                              );
                            }
                          }
                        }
                      },
                    ),
                    Container(
                      // constraints: const BoxConstraints(
                      //   maxHeight: 100,
                      // ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.onSecondary,
                      )),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedPlayers.value.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(selectedPlayers.value[index].username),
                        ),
                      ),
                    )
                  ],
                ),
              const SizedBox(height: 10),
              if (selectedGame.value != null)
                MyButtonWidget(
                  label: "Invite Players",
                  onPressed: () => invite(
                    selectedGame.value!,
                    selectedPlayers.value,
                    "invites you to join the ${selectedGame.value!.name} game",
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
