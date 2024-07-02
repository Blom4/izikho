import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/responsive/responsive.dart';

class CustomBottomAppBar extends ConsumerWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: Responsive.isMobile(context)
          ? null
          : const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: Responsive.isMobile(context)
            ? null
            : const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Tooltip(
            message: "Serve",
            child: IconButton(
              onPressed: () {
                //ref.read(krusaidRoomProvider.notifier).serveCards(6);
              },
              icon: const Icon(Icons.dialer_sip),
            ),
          ),
          Tooltip(
            message: "Shuffle",
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shuffle),
            ),
          ),
          Tooltip(
            message: "Chats",
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message),
            ),
          ),
          Tooltip(
            message: "Menu",
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
          ),
        ],
      ),
    );
  }
}
