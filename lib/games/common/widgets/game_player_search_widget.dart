import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/auth/model/profile_model.dart';

import '../../../chat/providers/chat_users_provider.dart';

class GamePlayerSearchWidget extends HookConsumerWidget {
  const GamePlayerSearchWidget({
    super.key,
    required this.hintText,
    required this.onPlayerSelected,
  });
  final String hintText;
  final void Function(ProfileModel) onPlayerSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = useState<List<ProfileModel>?>(null);
    final asyncPlayers = ref.watch(chatUsersProvider);

    return switch (asyncPlayers) {
      AsyncData(:final value) => Container(
          //color: Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (v) {
                  searchResults.value = value
                      .where(
                        (element) => "${element.username} ${element.email}"
                            .toLowerCase()
                            .contains(v.toLowerCase()),
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
                  itemCount: searchResults.value?.length ?? value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        searchResults.value?[index].username ??
                            value[index].username,
                      ),
                      onTap: () => onPlayerSelected(
                        searchResults.value?[index] ?? value[index],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      AsyncError(:final error) => Center(child: Text(error.toString())),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
