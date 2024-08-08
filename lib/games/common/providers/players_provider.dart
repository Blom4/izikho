import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:izikho/auth/model/profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/player_model.dart';

part 'players_provider.g.dart';

@riverpod
Stream<List<PlayerModel>> players(PlayersRef ref) {
  return SupabaseChatCore.instance.users().asyncMap(
        (event) => event
            .map(
              (e) => PlayerModel.fromProfile(
                ProfileModel.fromUser(e),
              ),
            )
            .toList(),
      );
}
