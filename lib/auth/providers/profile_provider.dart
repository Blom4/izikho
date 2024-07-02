import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/providers/supabase_provider.dart';
import '../model/profile.dart';

part 'profile_provider.g.dart';

@riverpod
class Profile extends _$Profile {
  @override
  FutureOr<ProfileModel> build() async {
    final userId = ref.read(supabaseProvider).auth.currentSession!.user.id;
    final data = await ref
        .read(supabaseProvider)
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return ProfileModel.fromMap(data);
  }

  Future<void> updateProfile(String username, String website) async {
    final user = ref.read(supabaseProvider).auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': username,
      'website': website,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await ref.read(supabaseProvider).from('profiles').upsert(updates);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    }
  }
}
