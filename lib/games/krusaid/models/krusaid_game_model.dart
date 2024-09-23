// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:playing_cards/playing_cards.dart';

import '../../common/models/game_model.dart';
import '../../common/models/player_model.dart';
import 'krusaid_player_model.dart';
import '../../common/models/game_playing_card.dart';

class KrusaidGameOptions extends GameOptions {
  final double servedCards;

  KrusaidGameOptions({
  
    required super.gameType,
    required super.gameMode,
    required super.players,
    required super.gamePlayerType,
    required this.servedCards,
  });
}

class KrusaidGameState {
  final KrusaidGameModel data;
  final bool loading;
  final String? error;

  KrusaidGameState({
    required this.data,
    this.loading = false,
    this.error,
  });
  KrusaidGameState.loading({
    this.loading = true,
    required this.data,
    this.error,
  });
  KrusaidGameState.error({
    required this.error,
    required this.data,
    this.loading = false,
  });

  @override
  bool operator ==(covariant KrusaidGameState other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.loading == loading &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ loading.hashCode ^ error.hashCode;
}

class KrusaidGameModel extends GameModel<KrusaidPlayerModel> {
  final List<GamePlayingCard> playedCards;
  final List<GamePlayingCard> deck;
  final int turnIndex;
  final bool served;
  bool direction;
  Playable playable;
  final double servedCards;

  KrusaidGameModel({
    super.id,
    super.gameOver,
    super.profileId,
    super.started,
    required super.gameType,
    required super.gameMode,
    required super.players,
    required this.deck,
    required this.servedCards,
    this.playedCards = const [],
    this.turnIndex = 0,
    this.playable = Playable.any,
    this.direction = true,
    this.served = false,
  });

  factory KrusaidGameModel.fromMap(Map<String, dynamic> map) {
    final extra = map['extra_props'] as Map<String, dynamic>;
    return KrusaidGameModel(
      id: map['id'] as String,
      gameType: GameType.values.firstWhere((e) => e.name == map['game_type']),
      gameMode: GameMode.values.firstWhere((e) => e.name == map['game_mode']),
      players: List<KrusaidPlayerModel>.from(
        (map['players'] as List<dynamic>).map<PlayerModel>(
          (x) => PlayerModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      started: map['started'] as bool,
      gameOver: map['game_over'] as bool,
      playedCards: List<GamePlayingCard>.from(
        (extra['played_cards'] as List<dynamic>).map<GamePlayingCard>(
          (x) => GamePlayingCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      deck: List<GamePlayingCard>.from(
        (extra['deck'] as List<dynamic>).map<GamePlayingCard>(
          (x) => GamePlayingCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      playable: Playable.values.firstWhere((e) => e.name == extra['playable']),
      turnIndex: extra['turn_index'] as int,
      direction: extra['direction'] as bool,
      servedCards: extra['served_cards'] as double,
      served: extra['served'] as bool,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'game_type': gameType.name,
      'game_mode': gameMode.name,
      'players': players.map((x) => x.toMap()).toList(),
      'started': started,
      'game_over': gameOver,
      'extra_props': {
        'played_cards': playedCards.map((x) => x.toMap()).toList(),
        'deck': deck.map((x) => x.toMap()).toList(),
        'served_cards': servedCards,
        'playable': playable.name,
        'turn_index': turnIndex,
        'direction': direction,
        'served': served,
      }
    };
  }

  @override
  KrusaidGameModel copyWith({
    String? id,
    String? profileId,
    GameType? gameType,
    GameMode? gameMode,
    List<KrusaidPlayerModel>? players,
    bool? started,
    bool? gameOver,
    List<GamePlayingCard>? playedCards,
    List<GamePlayingCard>? deck,
    Playable? playable,
    int? turnIndex,
    double? servedCards,
    bool? direction,
    bool? served,
  }) {
    return KrusaidGameModel(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      gameType: gameType ?? this.gameType,
      gameMode: gameMode ?? this.gameMode,
      players: players ?? this.players,
      started: started ?? this.started,
      gameOver: gameOver ?? this.gameOver,
    
      playedCards: playedCards ?? this.playedCards,
      deck: deck ?? this.deck,
      playable: playable ?? this.playable,
      turnIndex: turnIndex ?? this.turnIndex,
      servedCards: servedCards ?? this.servedCards,
      direction: direction ?? this.direction,
      served: served ?? this.served,
    );
  }

  @override
  String toString() {
    return 'KrusaidGameModel(playedCards: $playedCards, deck: $deck, playable: $playable, turnIndex: $turnIndex, numOfPlayers: $numOfPlayers, direction: $direction, served: $served)';
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
  KrusaidPlayerModel get winner => players.firstWhere(
        (e) => gameOver && e.cards.isEmpty,
        orElse: () => KrusaidPlayerModel(
          id: 'No Id',
          username: 'No player',
          index: -1,
        ),
      );

  @override
  List<KrusaidPlayerModel> get otherPlayers {
    return players.where((e) => e.id != profileId).toList();
  }

  void shuffleDeck() {
    if (playedCards.isNotEmpty) {
      GamePlayingCard topcardplayed = playedCards.removeLast();
      deck.addAll(playedCards);
      playedCards.clear();
      playedCards.add(topcardplayed);
    }
    deck.shuffle();
  }

  KrusaidGameModel serveCards() {
    if (!served) {
      List<KrusaidPlayerModel> players = [];
      shuffleDeck();
      for (KrusaidPlayerModel player in this.players) {
        List<GamePlayingCard> playerCards = [];
        for (int i = 0; i < servedCards; i++) {
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

  KrusaidGameModel nextPlayState(GamePlayingCard card, Playable playable) {
    if (card.value == CardValue.jack) {
      direction = !direction;
    }

    if (card.suit == Suit.joker && playable == Playable.any) {
      this.playable = playable;
    }

    KrusaidPlayerModel me = _getCurrentPlayer(card);

    if (me.cards.isEmpty) {
      gameOver = true;
    }

    KrusaidPlayerModel nextPlayer = getNextPlayer(card);

    return copyWith(
      playedCards: [...playedCards, card],
      turnIndex: nextPlayer.index,
      playable: playable,
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

  KrusaidGameModel nextDeckState() {
    GamePlayingCard topDeckCard = deck.removeLast();

    if (deck.isEmpty) {
      shuffleDeck();
    }

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

  KrusaidGameModel nextShotState(KrusaidPlayerModel shotPlayer) {
    KrusaidPlayerModel nextPlayer = getNextPlayer();
    final List<GamePlayingCard> takenCards = [];
    for (int i = 0; i < shotPlayer.cardsToTake; i++) {
      var topCard = deck.removeLast();
      if (deck.isEmpty) {
        shuffleDeck();
      }
      takenCards.add(topCard);
    }
    return copyWith(
      turnIndex: nextPlayer.index,
      players: [
        for (final player in players)
          if (player.index == shotPlayer.index)
            shotPlayer.copyWith(
              isTurn: false,
              isShot: false,
              cardsToTake: 0,
              cards: [...shotPlayer.cards, ...takenCards],
            )
          else if (player.index == nextPlayer.index)
            nextPlayer
          else
            player
      ],
    );
  }

  KrusaidPlayerModel getNextPlayer([GamePlayingCard? card]) {
    if (gameOver || card == null) {
      return players[_nextIndex].copyWith(
        isShot: false,
        isTurn: true,
        cardsToTake: 0,
      );
    }
    switch (card.value) {
      case CardValue.two:
        return players[_nextIndex].copyWith(
          isShot: true,
          cardsToTake: players[_currentIndex].isShot
              ? players[_currentIndex].cardsToTake + 2
              : 2,
          isTurn: true,
        );
      case (CardValue.joker_1 || CardValue.joker_2):
        if (playable != Playable.any) {
          return players[_nextIndex].copyWith(
            isShot: false,
            isTurn: true,
            cardsToTake: 0,
          );
        }
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

  KrusaidPlayerModel _getCurrentPlayer(GamePlayingCard card) => currentPlayer.copyWith(
        isTurn: false,
        isShot: false,
        cardsToTake: 0,
        cards: players[_currentIndex]
            .cards
            .where((element) => element != card)
            .toList(),
      );

  bool isPlayable(GamePlayingCard card) {
    return playable == Playable.any ||
        card.value == CardValue.eight ||
        card.suit == Suit.joker ||
        playable.suit == card.suit ||
        playedCards.last.value == card.value;
  }

  KrusaidPlayerModel get turnPlayer => players[turnIndex];

  int get _currentIndex => turnIndex;

  bool get isMyTurn => currentPlayer.index == turnIndex;
  bool get isWinner => currentPlayer.index == winner.index;
  bool get islastPlayCard => currentPlayer.cards.length == 1;

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
