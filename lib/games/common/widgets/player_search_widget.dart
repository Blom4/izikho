import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/auth/model/profile_model.dart';

class PlayerSearchWidget extends HookConsumerWidget {
  const PlayerSearchWidget({
    super.key,
    required this.profiles,
    required this.hintText,
    required this.onPlayerSelected,
  });
  final String hintText;
  final void Function(ProfileModel) onPlayerSelected;
  final List<ProfileModel> profiles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = useState(profiles);
    return Container(
      //color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              searchResults.value = profiles
                  .where(
                    (element) => "${element.username} ${element.email}"
                        .toLowerCase()
                        .contains(value.toLowerCase()),
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
                  title: Text(searchResults.value[index].username),
                  onTap: () => onPlayerSelected(searchResults.value[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
