import 'package:flutter/material.dart';

import '../../../common/data/game_data.dart';
import '../../../common/responsive/responsive.dart';
import '../../../common/widgets/game_tile_widget.dart';

class GameScreen extends StatelessWidget {
  static const String routename = 'game_screen';
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Games"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GameTileWidget(
                  gameModel: games[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
