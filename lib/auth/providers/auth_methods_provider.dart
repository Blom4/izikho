import 'package:flutter/material.dart';
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/providers/supabase_provider.dart';
import 'auth_change_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final authMethodsProvider = ChangeNotifierProvider<_AuthMethods>((ref) {
  return _AuthMethods(ref);
});

class _AuthMethods extends ChangeNotifier {
  final Ref ref;
  _AuthMethods(this.ref) {
    ref.listen(authChangeProvider, (_, next) => notifyListeners);
  }

  Future<void> login(String email, String password) async {
    try {
      await ref.read(supabaseProvider).auth.signInWithPassword(
            email: email,
            password: password,
          );
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  Future<void> register(String username, String email, String password) async {
    try {
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
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } on PostgrestException catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await ref.read(supabaseProvider).auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }
}
