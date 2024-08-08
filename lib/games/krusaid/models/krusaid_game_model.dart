import 'package:playing_cards/playing_cards.dart';

import '../../common/models/game_model.dart';
import '../../common/models/player_model.dart';
import '../components/play_card.dart';
import 'krusaid_player_model.dart';

class KrusaidGameModel extends GameModel<KrusaidPlayerModel> {
  final List<PlayCard> playedCards;
  final List<PlayCard> deck;
  final PlayCard? playableCard;
  final int turnIndex;
  //final int numOfPlayers;
  bool direction;
  final bool served;

  KrusaidGameModel({
    super.id,
    super.turn,
    super.gameOver,
    super.profileId,
    super.started,
    required super.gameType,
    required super.players,
    required this.deck,
    this.playedCards = const [],
    this.turnIndex = 0,
    this.playableCard,
    //this.numOfPlayers = 3,
    this.direction = true,
    this.served = false,
  });

  @override
  KrusaidGameModel copyWith({
    String? id,
    String? profileId,
    GameType? gameType,
    List<KrusaidPlayerModel>? players,
    bool? started,
    bool? gameOver,
    PlayerModel? turn,
    List<PlayCard>? playedCards,
    List<PlayCard>? deck,
    PlayCard? playableCard,
    int? turnIndex,
    //int? numOfPlayers,
    bool? direction,
    bool? served,
  }) {
    return KrusaidGameModel(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      gameType: gameType ?? this.gameType,
      players: players ?? this.players,
      started: started ?? this.started,
      gameOver: gameOver ?? this.gameOver,
      turn: turn ?? this.turn,
      playedCards: playedCards ?? this.playedCards,
      deck: deck ?? this.deck,
      playableCard: playableCard ?? this.playableCard,
      turnIndex: turnIndex ?? this.turnIndex,
      //numOfPlayers: numOfPlayers ?? this.numOfPlayers,
      direction: direction ?? this.direction,
      served: served ?? this.served,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'game_type': gameType.name,
      'players': players.map((x) => x.toMap()).toList(),
      'started': started,
      'game_over': gameOver,
      'turn': turn?.toMap(),
      'extra_props': {
        'played_cards': playedCards.map((x) => x.toMap()).toList(),
        'deck': deck.map((x) => x.toMap()).toList(),
        'playable_card': playableCard?.toMap(),
        'turn_index': turnIndex,
        'direction': direction,
        'served': served,
      }
    };
  }

  factory KrusaidGameModel.fromMap(Map<String, dynamic> map) {
    final extra = map['extra_props'] as Map<String, dynamic>;
    return KrusaidGameModel(
      id: map['id'] as String,
      gameType: GameType.values.firstWhere((e) => e.name == map['game_type']),
      players: List<KrusaidPlayerModel>.from(
        (map['players'] as List<dynamic>).map<PlayerModel>(
          (x) => PlayerModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      started: map['started'] as bool,
      gameOver: map['game_over'] as bool,
      turn: map['turn'] != null
          ? PlayerModel.fromMap(map['turn'] as Map<String, dynamic>)
          : null,
      playedCards: List<PlayCard>.from(
        (extra['played_cards'] as List<dynamic>).map<PlayCard>(
          (x) => PlayCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      deck: List<PlayCard>.from(
        (extra['deck'] as List<dynamic>).map<PlayCard>(
          (x) => PlayCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      playableCard: extra['playable_card'] != null
          ? PlayCard.fromMap(extra['playable_card'] as Map<String, dynamic>)
          : null,
      turnIndex: extra['turn_index'] as int,
      //numOfPlayers: extra['num_of_players'] as int,
      direction: extra['direction'] as bool,
      served: extra['served'] as bool,
    );
  }

  @override
  String toString() {
    return 'KrusaidGameModel(playedCards: $playedCards, deck: $deck, playableCard: $playableCard, turnIndex: $turnIndex, numOfPlayers: $numOfPlayers, direction: $direction, served: $served)';
  }

  void shuffleDeck() {
    if (playedCards.isNotEmpty) {
      PlayCard topcardplayed = playedCards.removeLast();
      deck.addAll(playedCards);
      playedCards.clear();
      playedCards.add(topcardplayed);
    }
    deck.shuffle();
  }

  KrusaidGameModel serveCards(int numOfcards) {
    if (!served) {
      List<KrusaidPlayerModel> players = [];
      shuffleDeck();
      for (KrusaidPlayerModel player in this.players) {
        List<PlayCard> playerCards = [];
        for (int i = 0; i < numOfcards; i++) {
          if (deck.isNotEmpty) {
            playerCards.add(deck.removeLast());
          }
        }
        players.add(player.copyWith(cards: playerCards));
      }
      return copyWith(players: players, served: true);
    }
    throw Exception('Room already served');
  }

  @override
  KrusaidPlayerModel get currentPlayer {
    return players.firstWhere(
      (e) => e.id == profileId,
      orElse: () => KrusaidPlayerModel(
        id: 'No Id',
        username: 'No player',
        index: -1,
      ),
    );
  }

  @override
  List<KrusaidPlayerModel> get otherPlayers {
    return players.where((e) => e.id != profileId).toList();
  }

  // void handleDeckCard(PlayCard card) {
  //   state.players[_currentIndex] = state.players[_currentIndex].copyWith(
  //     cards: [
  //       ...state.players[_currentIndex].cards,
  //       card,
  //     ],
  //   );
  //   state.deck.remove(card);
  //   state = state.copyWith(
  //    // me: state.players[_currentIndex],
  //    // turn: state.players[_currentIndex],
  //   );
  //   updateRoom();
  // }
  KrusaidGameModel nextDeckState() {
    PlayCard topDeckCard = deck.removeLast();
    return copyWith(
      players: [
        for (var player in players)
          if (player.isTurn)
            player.copyWith(cards: [...player.cards, topDeckCard])
          else
            player
      ],
    );
  }

  KrusaidGameModel nextState({required PlayCard card, PlayCard? playable}) {
    if (card.value == CardValue.jack) {
      direction = !direction;
    }

    KrusaidPlayerModel me = _getCurrentPlayer(card);
    KrusaidPlayerModel nextPlayer = _nextPlayer(card);

    return copyWith(
      playedCards: [...playedCards, card],
      turnIndex: nextPlayer.index,
      playableCard: playable ?? card,
      players: players.map((e) {
        if (e.index == nextPlayer.index) {
          if (me.index == nextPlayer.index) {
            return me.copyWith(
              isTurn: true,
              cardsToTake: 0,
              isShot: false,
            );
          }
          return nextPlayer;
        } else if (e.index == me.index) {
          return me;
        } else {
          return e;
        }
      }).toList(),
    );
  }

  bool isPlayable(PlayCard card) {
    return playableCard == null ||
        playableCard!.suit == Suit.joker ||
        card.value == CardValue.eight ||
        card.suit == Suit.joker ||
        playableCard!.suit == card.suit ||
        playableCard!.value == card.value;
  }

  KrusaidPlayerModel get turnPlayer => players[turnIndex];

  KrusaidPlayerModel _getCurrentPlayer(PlayCard card) => currentPlayer.copyWith(
        isTurn: false,
        isShot: false,
        cardsToTake: 0,
        cards: players[_currentIndex]
            .cards
            .where((element) => element != card)
            .toList(),
      );

  KrusaidPlayerModel _nextPlayer(PlayCard card) {
    switch (card.value) {
      case CardValue.two:
        return players[_nextIndex].copyWith(
          isShot: true,
          cardsToTake: players[_currentIndex].isShot
              ? players[_currentIndex].cardsToTake + 2
              : 2,
          isTurn: true,
        );
      case CardValue.joker_1 || CardValue.joker_2:
        return players[_nextIndex].copyWith(
          isShot: true,
          cardsToTake: players[_currentIndex].isShot
              ? players[_currentIndex].cardsToTake + 4
              : 4,
          isTurn: true,
        );
      case CardValue.seven:
        return players[_skipIndex].copyWith(
          isShot: false,
          isTurn: true,
          cardsToTake: 0,
        );

      default:
        if (card.value == CardValue.jack && numOfPlayers == 2) {
          return players[_currentIndex].copyWith(
            isShot: false,
            isTurn: true,
            cardsToTake: 0,
          );
        }
        return players[_nextIndex].copyWith(
          isShot: false,
          isTurn: true,
          cardsToTake: 0,
        );
    }
  }

  int get _currentIndex => turnIndex;

  int get _nextIndex {
    if (direction) {
      return (_currentIndex + 1) % numOfPlayers;
    }
    return _currentIndex == 0 ? numOfPlayers - 1 : _currentIndex - 1;
  }

  int get _skipIndex {
    if (numOfPlayers == 2) {
      return _currentIndex;
    }
    if (direction) {
      if (numOfPlayers.isEven) {
        return _currentIndex + 3 >= numOfPlayers
            ? (_currentIndex + 3) - numOfPlayers
            : _currentIndex + 3;
      }
      return _currentIndex + 2 >= numOfPlayers
          ? (_currentIndex + 2) - numOfPlayers
          : _currentIndex + 2;
    }
    if (numOfPlayers.isEven) {
      return _currentIndex < 3
          ? (_currentIndex - 3) + numOfPlayers
          : _currentIndex - 3;
    }
    return _currentIndex < 2
        ? (_currentIndex - 2) + numOfPlayers
        : _currentIndex - 2;
  }

  int get deckCount => deck.length;
  int get numOfPlayers => players.length;
}
