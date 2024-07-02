import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../common/providers/supabase_provider.dart';

final authChangeProvider =
    StreamNotifierProvider<_AuthChangeNotifier, AuthState>(_AuthChangeNotifier.new);

class _AuthChangeNotifier extends StreamNotifier<AuthState> {
  @override
  Stream<AuthState> build() {
    return ref.read(supabaseProvider).auth.onAuthStateChange;
  }
}
