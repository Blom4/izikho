import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/providers/supabase_provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  static const String routename = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _websiteController;
  late ValueNotifier<bool> _loading;
  Future<void> _signOut() async {
    try {
      await ref.read(supabaseProvider).auth.signOut();
    } on AuthException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    }
  }

  Future<void> updateProfile() async {
    _loading.value = true;
    try {
      await ref.read(profileProvider.notifier).updateProfile(
            _usernameController.text.trim(),
            _websiteController.text.trim(),
          );

      _loading.value = false;
    } on PostgrestException catch (e) {
      if (mounted) {
        _loading.value = false;
        context.showSnackBar(e.message, isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //final profile = ref.watch(profileProvider);

    _usernameController = useTextEditingController();
    _websiteController = useTextEditingController();
    _loading = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'User Name'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _websiteController,
            decoration: const InputDecoration(labelText: 'Website'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _loading.value ? null : updateProfile,
            child: Text(_loading.value ? 'Saving...' : 'Update'),
          ),
          const SizedBox(height: 18),
          TextButton(onPressed: _signOut, child: const Text('Sign Out')),
        ],
      ),
    );
  }
}
