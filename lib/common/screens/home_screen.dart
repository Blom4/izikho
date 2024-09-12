import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/providers/auth_methods_provider.dart';
import '../../auth/providers/profile_provider.dart';
import '../../chat/widgets/user_avatar.dart';
import '../../games/common/screens/notifications_screen.dart';
import '../../games/common/screens/game_start_screen.dart';
import '../../games/common/widgets/recent_notifications.dart';
import '../widgets/my_button.dart';
import '../widgets/online_friends_widget.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  static const String routename = 'home_screen';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _logout() async {
    await ref.read(authMethodsProvider).logout();
  }

  @override
  Widget build(BuildContext context) {
    var asyncProfile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("EZIK'HO"),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(NotificationsScreen.routename);
            },
            icon: const Badge(
              label: Text("9+"),
              child: Icon(Icons.notifications),
            ),
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  switch (asyncProfile) {
                    AsyncData(:final value) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: MyUserAvatar(
                              profile: value,
                              radius: 25,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, Welcome',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontSize: 18, letterSpacing: 2),
                              ),
                              Text(
                                value.username,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    AsyncError(:final error) => Text(error.toString()),
                    _ => const Center(child: CircularProgressIndicator()),
                  },
                  const SizedBox(height: 30),
                  //actions
                  Column(
                    children: [
                      MyButtonWidget(
                        label: "Start Game",
                        onPressed: () =>
                            context.pushNamed(GameStartScreen.routename),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  //online friends
                  const OnlineFriendsWidget(),
                  const SizedBox(height: 10),
                  //recent notifications
                  const RecentNotifications(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
