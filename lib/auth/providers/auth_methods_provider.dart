import 'package:flutter/material.dart';
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/providers/supabase_provider.dart';
import 'auth_change_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final authMethodsProvider = ChangeNotifierProvider<_AuthMethods>((ref) {
  return _AuthMethods(ref);
});

class _AuthMethods extends ChangeNotifier {
  final Ref ref;
  _AuthMethods(this.ref) {
    ref.listen(authChangeProvider.future, (_, next) => notifyListeners);
  }

  Future<void> login(String email, String password) async {
    await ref.read(supabaseProvider).auth.signInWithPassword(
          email: email,
          password: password,
        );
  }

  Future<void> register(String username, String email, String password) async {
    final response = await ref.read(supabaseProvider).auth.signUp(
          email: email,
          password: password,
        );
    await SupabaseChatCore.instance.updateUser(
      types.User(
        id: response.user!.id,
        metadata: {
          'email': email,
          'username': username,
        },
      ),
    );
  }

  Future<void> logout() async {
    await ref.read(supabaseProvider).auth.signOut();
  }
}
