// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:playing_cards/playing_cards.dart';
// import 'package:socket_io_client/socket_io_client.dart' as socket_io_client;

// import '../../../common/providers/socket_provider.dart';
// import '../components/error_occured.dart';
// import '../components/play_card.dart';
// import '../components/player.dart';
// import '../components/room.dart';
// import '../dialogs/eigtht_dialog.dart';
// import '../dialogs/joker_dialog.dart';
// import '../screens/krusaid_game_screen.dart';
// import '../screens/krusaid_waiting_screen.dart';
// import 'krusaid_player_provider.dart';
// import 'krusaid_room_provider.dart';

// final socketMethodsProvider =
//     Provider.family<_SocketMethods, BuildContext>((ref, context) {
//   return _SocketMethods(ref, context);
// });

// class _SocketMethods {
//   final Ref ref;
//   final BuildContext context;
//   late final socket_io_client.Socket _socket;

//   _SocketMethods(this.ref, this.context) {
//     _socket = ref.watch(socketProvider);

//     createRoomListener();
//     joinRoomListener();
//     errorOccuredListener();
//     serveCardsListener();
//     playListener();
//   }

//   void createRoom() {
//     final room = ref.read(krusaidRoomProvider.notifier).createRoom(
//           roomId: "Krusaid",
//           player: ref
//               .read(krusaidPlayerProvider.notifier)
//               .createPlayer(username: 'Player 1', index: 0),
//         );
//     _socket.emit("createRoom", {"id": room.id, "room": room});
//   }

//   void createRoomListener() {
//     _socket.on("createRoom", (data) {
//       final room = Room.fromMap(data);
//       ref.read(krusaidRoomProvider.notifier).room = room;
//       ref.read(krusaidPlayerProvider.notifier).player =
//           room.players.first.copyWith(joined: true);
//       context.goNamed(KrusaidWaitingScreen.routename);
//     });
//   }

//   void joinRoom() {
//     _socket.emit("joinRoom", {
//       "roomId": "Krusaid",
//       "player":
//           ref.read(krusaidPlayerProvider.notifier).joinRoom(username: "Player")
//     });
//   }

//   void joinRoomListener() {
//     _socket.on("joinRoom", (data) {
//       final room = Room.fromMap(data);
//       ref.read(krusaidRoomProvider.notifier).room = room;

//       if (room.players.length == room.numOfPlayers) {
//         if (!ref.read(krusaidPlayerProvider).joined) {
//           ref.read(krusaidPlayerProvider.notifier).player =
//               room.players.last.copyWith(joined: true);
//         }
//         serveCards(4);
//       } else {
//         if (!ref.read(krusaidPlayerProvider).joined) {
//           ref.read(krusaidPlayerProvider.notifier).player =
//               room.players.last.copyWith(joined: true);
//           context.goNamed(KrusaidWaitingScreen.routename);
//         }
//       }
//     });
//   }

//   void errorOccuredListener() {
//     _socket.on("errorOccured", (data) {
//       final error = ErrorOccured.fromMap(data);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(error.message)));
//     });
//   }

//   void serveCards(int numOfcards) {
//     final room = ref.read(krusaidRoomProvider.notifier).serveCards(numOfcards);
//     if (room != null) {
//       _socket.emit('serveCards', {"roomId": room.id, "roomData": room});
//     } else {
//       print("room already served");
//     }
//   }

//   void serveCardsListener() {
//     _socket.on("serveCards", (data) {
//       final room = Room.fromMap(data);
//       ref.read(krusaidRoomProvider.notifier).room = room;
//       ref.read(krusaidPlayerProvider.notifier).player = room.players.firstWhere(
//           (element) => element.index == ref.read(krusaidPlayerProvider).index);
//       context.goNamed(KrusaidGameScreen.routename);
//     });
//   }

//   void play(PlayCard card) {
//     Player me = ref.read(krusaidPlayerProvider);

//     if (me.isTurn) {
//       switch (card.value) {
//         case CardValue.eight:
//           showEightDialog(context).then((value) {
//             if (value != null) {
//               ref.read(krusaidPlayerProvider.notifier).player =
//                   ref.read(krusaidRoomProvider.notifier).currentPlayer(card);
//               _socket.emit("play", {
//                 "roomId":
//                     ref.read(krusaidRoomProvider.notifier).nextState(card).id,
//                 "roomData": ref
//                     .read(krusaidRoomProvider.notifier)
//                     .nextState(PlayCard(value.suit, card.value)),
//               });
//             }
//           });
//           break;
//         case CardValue.joker_1 || CardValue.joker_1:
//           showJokerDialog(context).then((value) {
//             if (value != null) {
//               if (!value) {
//                 showEightDialog(context).then((value) {
//                   if (value != null) {
//                     ref.read(krusaidPlayerProvider.notifier).player = ref
//                         .read(krusaidRoomProvider.notifier)
//                         .currentPlayer(card);
//                     _socket.emit("play", {
//                       "roomId": ref
//                           .read(krusaidRoomProvider.notifier)
//                           .nextState(card)
//                           .id,
//                       "roomData": ref
//                           .read(krusaidRoomProvider.notifier)
//                           .nextState(PlayCard(value.suit, card.value)),
//                     });
//                   }
//                 });
//               } else {
//                 ref.read(krusaidPlayerProvider.notifier).player =
//                     ref.read(krusaidRoomProvider.notifier).currentPlayer(card);
//                 _socket.emit("play", {
//                   "roomId":
//                       ref.read(krusaidRoomProvider.notifier).nextState(card).id,
//                   "roomData":
//                       ref.read(krusaidRoomProvider.notifier).nextState(card),
//                 });
//               }
//             }
//           });
//           break;
//         default:
//           final allowedCard = ref.read(krusaidRoomProvider).allowedCard;
//           print(allowedCard);
//           if (allowedCard != null) {
//             if (card.value == allowedCard.value ||
//                 card.suit == allowedCard.suit) {
//               ref.read(krusaidPlayerProvider.notifier).player =
//                   ref.read(krusaidRoomProvider.notifier).currentPlayer(card);
//               _socket.emit("play", {
//                 "roomId":
//                     ref.read(krusaidRoomProvider.notifier).nextState(card).id,
//                 "roomData":
//                     ref.read(krusaidRoomProvider.notifier).nextState(card),
//               });
//             }
//           } else {
//             ref.read(krusaidPlayerProvider.notifier).player =
//                 ref.read(krusaidRoomProvider.notifier).currentPlayer(card);

//             _socket.emit("play", {
//               "roomId":
//                   ref.read(krusaidRoomProvider.notifier).nextState(card).id,
//               "roomData":
//                   ref.read(krusaidRoomProvider.notifier).nextState(card),
//             });
//           }
//           break;
//       }
//     }
//   }

//   void playListener() {
//     _socket.on("play", (data) {
//       Room room = Room.fromMap(data);
//       Player me = room.players[room.turnIndex];

//       ref.read(krusaidRoomProvider.notifier).room = room;
//       if (ref.read(krusaidPlayerProvider).index == me.index) {
//         ref.read(krusaidPlayerProvider.notifier).player = me;
//       }
//     });
//   }
// }
