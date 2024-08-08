import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/chat/utils/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/model/profile_model.dart';

class RoomAvatar extends ConsumerWidget {
   const RoomAvatar({super.key,required this.room});
  final types.Room room;
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  User? user = SupabaseChatCore.instance.supabaseUser;
    var color = Colors.transparent;
  types.User? otherUser;

  if (room.type == types.RoomType.direct) {
    try {
      otherUser = room.users.firstWhere(
        (u) => u.id != user!.id,
      );

      color = getUserAvatarNameColor(ProfileModel.fromUser(otherUser));
    } catch (e) {
      // Do nothing if the other user is not found.
    }
  }

  final hasImage = room.imageUrl != null;
  final name = room.name ?? '';
  final Widget child = CircleAvatar(
    backgroundColor: hasImage ? Colors.transparent : color,
    backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
    radius: 20,
    child: !hasImage
        ? Text(
            name.isEmpty ? '' : name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          )
        : null,
  );
  if (otherUser == null) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: child,
    );
  }


  return Container(
    margin: const EdgeInsets.only(right: 16),
    child: UserOnlineStatusWidget(
      uid: otherUser.id,
      builder: (status) => Stack(
        alignment: Alignment.bottomRight,
        children: [
          child,
          if (status ==
              UserOnlineStatus
                  .online) 
            Container(
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
        ],
      ),
    ),
  );
  }
}


// Widget _buildAvatar(types.Room room) {
//   var color = Colors.transparent;
//   types.User? otherUser;

//   if (room.type == types.RoomType.direct) {
//     try {
//       otherUser = room.users.firstWhere(
//         (u) => u.id != _user!.id,
//       );

//       color = getUserAvatarNameColor(otherUser);
//     } catch (e) {
//       // Do nothing if the other user is not found.
//     }
//   }

//   final hasImage = room.imageUrl != null;
//   final name = room.name ?? '';
//   final Widget child = CircleAvatar(
//     backgroundColor: hasImage ? Colors.transparent : color,
//     backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
//     radius: 20,
//     child: !hasImage
//         ? Text(
//             name.isEmpty ? '' : name[0].toUpperCase(),
//             style: const TextStyle(color: Colors.white),
//           )
//         : null,
//   );
//   if (otherUser == null) {
//     return Container(
//       margin: const EdgeInsets.only(right: 16),
//       child: child,
//     );
//   }

//   // Se `otherUser` non è null, la stanza è diretta e possiamo mostrare l'indicatore di stato online.

//   return Container(
//     margin: const EdgeInsets.only(right: 16),
//     child: UserOnlineStatusWidget(
//       uid: otherUser.id,
//       builder: (status) => Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           child,
//           if (status ==
//               UserOnlineStatus
//                   .online) // Assumendo che `status` indichi lo stato online
//             Container(
//               width: 10,
//               height: 10,
//               margin: const EdgeInsets.only(right: 3, bottom: 3),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 2,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     ),
//   );
// }
