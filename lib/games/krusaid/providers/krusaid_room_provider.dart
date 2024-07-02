import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:playing_cards/playing_cards.dart';

import '../components/deck.dart';
import '../components/play_card.dart';
import '../components/player.dart';
import '../components/room.dart';

final krusaidRoomProvider =
    NotifierProvider<_KrusaidRoomNotifier, Room>(_KrusaidRoomNotifier.new);

class _KrusaidRoomNotifier extends Notifier<Room> {
  @override
  Room build() {
    return Room(
      id: "",
      players: [],
      playedCards: [],
      deck: myStandardFiftyFourCardDeck(),
      turnIndex: 0,
    );
  }

  Room createRoom({required String roomId, required Player player}) {
    Room room = state.copyWith(id: roomId, players: [player]);
    return room;
  }

  set room(Room room) {
    state = room;
  }

  void shuffleDeck() {
    if (state.playedCards.isNotEmpty) {
      PlayCard topcardplayed = state.playedCards.removeLast();
      state = state.copyWith(
        playedCards: [topcardplayed],
        deck: [...state.deck, ...state.playedCards],
      );
    }
    state.deck.shuffle();
  }

  Room? serveCards(int numOfcards) {
    if (!state.served) {
      List<Player> players = [];
      shuffleDeck();
      for (Player player in state.players) {
        List<PlayCard> playerCards = [];
        for (int i = 0; i < numOfcards; i++) {
          if (state.deck.isNotEmpty) {
            playerCards.add(state.deck.removeLast());
          }
        }
        players.add(player.copyWith(cards: playerCards));
      }
      return state.copyWith(players: players, served: true);
    }
    return null;
  }

  // void handleDeckCard(PlayCard card) {
  //   state.players[currentIndex] = state.players[currentIndex].copyWith(
  //     cards: [
  //       ...state.players[currentIndex].cards,
  //       card,
  //     ],
  //   );
  //   state.deck.remove(card);
  //   state = state.copyWith(
  //    // me: state.players[currentIndex],
  //    // turn: state.players[currentIndex],
  //   );
  //   updateRoom();
  // }

  Room nextState(PlayCard card) {
    if (card.value == CardValue.jack) {
      state = state.copyWith(
        direction: !state.direction,
      );
    }

    Player me = currentPlayer(card);
    Player nextPlayer = _nextPlayer(card);

    return state.copyWith(
      playedCards: [...state.playedCards, card],
      turnIndex: nextPlayer.index,
      allowedCard: card,
      players: state.players.map((e) {
        if (e.index == nextPlayer.index) {
          return nextPlayer;
        } else if (e.index == me.index) {
          return me;
        } else {
          return e;
        }
      }).toList(),
    );
  }

  Player currentPlayer(PlayCard card) => state.players[currentIndex].copyWith(
        isTurn: false,
        isShot: false,
        cardsToTake: 0,
        cards: state.players[currentIndex].cards
            .where((element) => element != card)
            .toList(),
      );

  Player _nextPlayer(PlayCard card) {
    switch (card.value) {
      case CardValue.two:
        return state.players[nextIndex].copyWith(
          isShot: true,
          cardsToTake: state.players[currentIndex].isShot
              ? state.players[currentIndex].cardsToTake + 2
              : 2,
          isTurn: true,
        );
      case CardValue.joker_1 || CardValue.joker_2:
        return state.players[nextIndex].copyWith(
          isShot: true,
          cardsToTake: state.players[currentIndex].isShot
              ? state.players[currentIndex].cardsToTake + 4
              : 4,
          isTurn: true,
        );
      case CardValue.seven:
        return state.players[skipIndex].copyWith(
          isShot: false,
          isTurn: true,
          cardsToTake: 0,
        );

      default:
        if (card.value == CardValue.jack && numOfPlayers == 2) {
          return state.players[currentIndex].copyWith(
            isShot: false,
            isTurn: true,
            cardsToTake: 0,
          );
        }
        return state.players[nextIndex].copyWith(
          isShot: false,
          isTurn: true,
          cardsToTake: 0,
        );
    }
  }

  int get currentIndex => state.turnIndex;

  int get nextIndex {
    if (state.direction) {
      return (currentIndex + 1) % numOfPlayers;
    }
    return currentIndex == 0 ? numOfPlayers - 1 : currentIndex - 1;
  }

  int get skipIndex {
    if (numOfPlayers == 2) {
      return currentIndex;
    }
    if (state.direction) {
      if (numOfPlayers.isEven) {
        return currentIndex + 3 >= numOfPlayers
            ? (currentIndex + 3) - numOfPlayers
            : currentIndex + 3;
      }
      return currentIndex + 2 >= numOfPlayers
          ? (currentIndex + 2) - numOfPlayers
          : currentIndex + 2;
    }
    if (numOfPlayers.isEven) {
      return currentIndex < 3
          ? (currentIndex - 3) + numOfPlayers
          : currentIndex - 3;
    }
    return currentIndex < 2
        ? (currentIndex - 2) + numOfPlayers
        : currentIndex - 2;
  }

  int get deckCount => state.deck.length;
  int get numOfPlayers => state.players.length;

  // void testFunction() {
  //   debugPrint("Players----------------------------------------$numOfPlayers");
  //   debugPrint("-------------------Me         -----------------------------");
  //   debugPrint("${state.me}");
  //   debugPrint("-------------------Next Turn-------------------------------");
  //   debugPrint("${state.turn}");
  //   debugPrint("Direction--------------------------------${state.direction}");
  //   debugPrint("CurrentIndex----------------------------------$currentIndex");
  //   debugPrint("NextIndex----------------------------------------$nextIndex");
  //   debugPrint("SkipIndex----------------------------------------$skipIndex");
  //   debugPrint("--------------------Played Cards---------------------------");
  //   debugPrint("${state.playedCards}");
  //   debugPrint("**************************End******************************");
  // }
}
