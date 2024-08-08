import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../chat/providers/chat_users_provider.dart';
import '../../chat/widgets/user_avatar.dart';
import 'section_header_widget.dart';

class OnlineFriendsWidget extends ConsumerWidget {
  const OnlineFriendsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChatUsers = ref.watch(chatUsersProvider);
    return Column(
      children: [
        SectionHeaderWidget(
          title: "Online Friends",
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        switch (asyncChatUsers) {
          AsyncData(:final value) => SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final profile = value[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          MyUserAvatar(profile: profile),
                          Text(
                            profile.username,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          AsyncError(:final error) => Text(error.toString()),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ],
    );
  }
}
