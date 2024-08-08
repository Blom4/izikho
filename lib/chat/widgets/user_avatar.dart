import 'package:flutter/material.dart';
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/model/profile_model.dart';
import '../utils/colors.dart';

class MyUserAvatar extends ConsumerWidget {
  const MyUserAvatar({
    super.key,
    required this.profile,
    this.radius = 20,
  });
  final ProfileModel profile;
  final double? radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = getUserAvatarNameColor(profile);
    final hasImage = profile.avatarURL != null;
    final name = getUserName(profile);
    return UserOnlineStatusWidget(
      uid: profile.id,
      builder: (status) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor: hasImage ? Colors.transparent : color,
            backgroundImage: hasImage ? NetworkImage(profile.avatarURL!) : null,
            radius: radius,
            child: !hasImage
                ? Text(
                    name.isEmpty ? '' : name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )
                : null,
          ),
          if (status == UserOnlineStatus.offline)
            Positioned(
              bottom: -1.5,
              right: -1.5,
              child: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 3, bottom: 3),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
