import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/game_model.dart';

class GameSearchWidget extends HookConsumerWidget {
  const GameSearchWidget({
    super.key,
    required this.hintText,
    required this.onGameSelected,
  });
  
  final String hintText;
  final void Function(GameType) onGameSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = useState(GameType.values);
    return Container(
      //color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              searchResults.value = GameType.values
                  .where(
                    (element) =>
                        element.name.toLowerCase().contains(value.toLowerCase()),
                  )
                  .toList();
            },
            decoration: InputDecoration(
              hintText: hintText,
              isDense: true,
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults.value[index].name),
                  onTap: () => onGameSelected(searchResults.value[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
