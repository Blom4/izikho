import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../../chat/screens/chat_rooms_screen.dart';
import '../responsive/responsive.dart';
import '../../games/common/screens/game_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("IFO LAPENG"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
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
                  //online friends
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Online Friends",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("See All"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const CircleAvatar(),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Player ${index + 1}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //options

                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: [
                      HomeCard(
                        icon: Icons.chat,
                        title: "Chats",
                        onTap: () => context.goNamed(ChatRoomsScreen.routename),
                      ),
                      HomeCard(
                        icon: Icons.gamepad,
                        title: "Games",
                        onTap: () => context.goNamed(GameScreen.routename),
                      ),
                      HomeCard(
                        icon: Icons.info,
                        title: "About",
                        onTap: () {},
                      ),
                      HomeCard(
                        icon: Icons.settings,
                        title: "  Settings",
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   static const String routename = 'home_screen';
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return NestedScrollView(
//       headerSliverBuilder: (context, innerBoxIsScrolled) {
//         return [
//           SliverAppBar(
//             floating: true,
//             //forceElevated: innerBoxIsScrolled,
//             pinned: true,
//             expandedHeight: 250,
//             title: const Text("Home"),
//             actions: [
//               IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Badge(
//                   label: Text("9+"),
//                   child: Icon(Icons.notifications),
//                 ),
//               ),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.parallax,
//               background: Container(
//                 margin: const EdgeInsets.only(top: kBottomNavigationBarHeight),
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.asset(
//                       "assets/images/eagle.jpg",
//                       fit: BoxFit.cover,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Theme.of(context).primaryColor.withOpacity(0.5)
//                           // gradient: LinearGradient(
//                           //   colors: [
//                           //     Colors.amber.withOpacity(0.1),
//                           //     Theme.of(context).primaryColor.withOpacity(0.5),
//                           //   ],
//                           //   stops: const [.2, .8],
//                           //   begin: Alignment.topCenter,
//                           //   end: Alignment.bottomCenter,
//                           //),
//                           ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 20),
//                             Text(
//                               "IFO LAPENG",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleLarge
//                                   ?.copyWith(
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               "Platform for playing and chatting with friends and familly.",
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge
//                                   ?.copyWith(
//                                     fontWeight: FontWeight.w700,
//                                     wordSpacing: 4,
//                                   ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ];
//       },
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Online Friends",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge
//                         ?.copyWith(fontWeight: FontWeight.w700),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text("See All"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 60,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: 8,
//                   itemBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [
//                             const CircleAvatar(),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Container(
//                                 width: 10,
//                                 height: 10,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.lightBlue,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text("Player ${index + 1}"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Popular Games",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyLarge
//                         ?.copyWith(fontWeight: FontWeight.w700),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text("See All"),
//                   ),
//                 ],
//               ),
//               GridView.builder(
//                 itemCount: 4,
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                 ),
//                 itemBuilder: (context, index) =>
//                     GameTileWidget(gameModel: games[index]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
