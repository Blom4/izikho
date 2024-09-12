import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../auth/model/profile_model.dart';
import '../../../common/widgets/my_button.dart';
import '../../morabaraba/constants/colors.dart';
import '../models/game_model.dart';
import '../models/player_model.dart';
import 'player_search_widget.dart';

class GameOptionTileWidget extends StatelessWidget {
  const GameOptionTileWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final void Function()? onTap;
  final IconData icon;
  final Widget? subtitle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: onTap,
      splashColor: Colors.blueGrey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1.5,
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                ),
                if (subtitle != null) subtitle!
              ],
            ),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}

class GameOptionsContainerWidget extends StatelessWidget {
  const GameOptionsContainerWidget({
    super.key,
    required this.children,
    required this.gameType,
    required this.onStartGame,
    required this.buttonLabel,
  });
  final GameType gameType;
  final void Function()? onStartGame;
  final String buttonLabel;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1.5,
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  spreadRadius: 1.5,
                  blurRadius: 2,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.games),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${gameType.name} options",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                const Icon(Icons.games),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ...children,
                MyButtonWidget(
                  label: buttonLabel,
                  onPressed: onStartGame,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameOptionCardWidget extends StatelessWidget {
  const GameOptionCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                Icon(icon),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlayersGameOptionCardWidget<T extends PlayerModel>
    extends HookConsumerWidget {
  const PlayersGameOptionCardWidget({
    super.key,
    required this.playerType,
    required this.onSearchOnlinePlayer,
  });
  final void Function(List<T>) onSearchOnlinePlayer;
  final GamePlayerType playerType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlayers = useState<List<T>>([]);

    Future<void> searchPlayer() async {
      var results = await showModalBottomSheet<ProfileModel?>(
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        builder: (context) {
          return PlayerSearchWidget(
            hintText: 'Search Players',
            onPlayerSelected: (item) {
              Navigator.of(context).pop(item);
            },
          );
        },
      );
      if (results != null) {
        final uniquePlayers = <T>{
          ...selectedPlayers.value,
          PlayerModel.fromProfile(results, playerType: playerType) as T,
        }.toList();
        onSearchOnlinePlayer(uniquePlayers);
        selectedPlayers.value = uniquePlayers;
      }
    }

    return GameOptionCardWidget(
      icon: Icons.people_outlined,
      title: 'Invite Players',
      children: [
        for (final player in selectedPlayers.value)
          ListTile(
            title: Text(player.username),
            trailing: IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: () => selectedPlayers.value =
                  selectedPlayers.value.where((e) => e != player).toList(),
            ),
          ),
        TextButton.icon(
          icon: const Icon(Icons.add_circle),
          label: const Text("Add Player"),
          onPressed: searchPlayer,
          style: TextButton.styleFrom(
            minimumSize: const Size.fromHeight(20),
            padding: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
