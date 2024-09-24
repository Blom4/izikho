// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:playing_cards/playing_cards.dart';

import '../../common/models/game_model.dart';
import '../../common/models/player_model.dart';
import 'ak47_player_model.dart';
import '../../common/models/game_playing_card.dart';

class Ak47GameOptions extends GameOptions {
  final double servedCards;

  Ak47GameOptions({
  
    required super.gameType,
    required super.gameMode,
    required super.players,
    required super.gamePlayerType,
    required this.servedCards,
  });
}

class Ak47GameState {
  final Ak47GameModel data;
  final bool loading;
  final String? error;

  Ak47GameState({
    required this.data,
    this.loading = false,
    this.error,
  });
  Ak47GameState.loading({
    this.loading = true,
    required this.data,
    this.error,
  });
  Ak47GameState.error({
    required this.error,
    required this.data,
    this.loading = false,
  });

  @override
  bool operator ==(covariant Ak47GameState other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.loading == loading &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ loading.hashCode ^ error.hashCode;
}

class Ak47GameModel extends GameModel<Ak47PlayerModel> {
  final List<GamePlayingCard> playedCards;
  final List<GamePlayingCard> deck;
  final int turnIndex;
  final bool served;
  bool direction;
  Playable playable;
  final double servedCards;

  Ak47GameModel({
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

  factory Ak47GameModel.fromMap(Map<String, dynamic> map) {
    final extra = map['extra_props'] as Map<String, dynamic>;
    return Ak47GameModel(
      id: map['id'] as String,
      gameType: GameType.values.firstWhere((e) => e.name == map['game_type']),
      gameMode: GameMode.values.firstWhere((e) => e.name == map['game_mode']),
      players: List<Ak47PlayerModel>.from(
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
  Ak47GameModel copyWith({
    String? id,
    String? profileId,
    GameType? gameType,
    GameMode? gameMode,
    List<Ak47PlayerModel>? players,
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
    return Ak47GameModel(
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
    return 'Ak47GameModel(playedCards: $playedCards, deck: $deck, playable: $playable, turnIndex: $turnIndex, numOfPlayers: $numOfPlayers, direction: $direction, served: $served)';
  }

  @override
  Ak47PlayerModel get currentPlayer {
    return players.firstWhere(
      (e) => e.id == profileId,
      orElse: () => Ak47PlayerModel(
        id: 'No Id',
        username: 'No player',
        index: -1,
      ),
    );
  }

  @override
  Ak47PlayerModel get winner => players.firstWhere(
        (e) => gameOver && e.cards.isEmpty,
        orElse: () => Ak47PlayerModel(
          id: 'No Id',
          username: 'No player',
          index: -1,
        ),
      );

  @override
  List<Ak47PlayerModel> get otherPlayers {
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

  Ak47GameModel serveCards() {
    if (!served) {
      List<Ak47PlayerModel> players = [];
      shuffleDeck();
      for (Ak47PlayerModel player in this.players) {
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

  Ak47GameModel nextPlayState(GamePlayingCard card, Playable playable) {
    if (card.value == CardValue.jack) {
      direction = !direction;
    }

    if (card.suit == Suit.joker && playable == Playable.any) {
      this.playable = playable;
    }

    Ak47PlayerModel me = _getCurrentPlayer(card);

    if (me.cards.isEmpty) {
      gameOver = true;
    }

    Ak47PlayerModel nextPlayer = getNextPlayer(card);

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

  Ak47GameModel nextDeckState() {
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

  Ak47GameModel nextShotState(Ak47PlayerModel shotPlayer) {
    Ak47PlayerModel nextPlayer = getNextPlayer();
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

  Ak47PlayerModel getNextPlayer([GamePlayingCard? card]) {
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

  Ak47PlayerModel _getCurrentPlayer(GamePlayingCard card) => currentPlayer.copyWith(
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

  Ak47PlayerModel get turnPlayer => players[turnIndex];

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
