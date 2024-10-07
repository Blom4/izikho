import '../../common/models/game_model.dart';
import '../../common/models/player_model.dart';
import 'fivecards_player_model.dart';
import '../../common/models/game_playing_card.dart';

class FivecardsGameOptions extends GameOptions {
  final double servedCards;

  FivecardsGameOptions({
    required super.gameType,
    required super.gameMode,
    required super.players,
    required super.gamePlayerType,
    this.servedCards = 5,
  });
}

class FivecardsGameState {
  final FivecardsGameModel data;
  final bool loading;
  final String? error;

  FivecardsGameState({
    required this.data,
    this.loading = false,
    this.error,
  });
  FivecardsGameState.loading({
    this.loading = true,
    required this.data,
    this.error,
  });
  FivecardsGameState.error({
    required this.error,
    required this.data,
    this.loading = false,
  });

  @override
  bool operator ==(covariant FivecardsGameState other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.loading == loading &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ loading.hashCode ^ error.hashCode;
}

class FivecardsGameModel extends GameModel<FivecardsPlayerModel> {
  final List<GamePlayingCard> playedCards;
  final List<GamePlayingCard> deck;
  final int turnIndex;
  final bool served;
  final double servedCards;

  FivecardsGameModel({
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
    this.served = false,
  });

  factory FivecardsGameModel.fromMap(Map<String, dynamic> map) {
    final extra = map['extra_props'] as Map<String, dynamic>;
    return FivecardsGameModel(
      id: map['id'] as String,
      gameType: GameType.values.firstWhere((e) => e.name == map['game_type']),
      gameMode: GameMode.values.firstWhere((e) => e.name == map['game_mode']),
      players: List<FivecardsPlayerModel>.from(
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
      turnIndex: extra['turn_index'] as int,
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
        'turn_index': turnIndex,
        'served': served,
      }
    };
  }

  @override
  FivecardsGameModel copyWith({
    String? id,
    String? profileId,
    GameType? gameType,
    GameMode? gameMode,
    List<FivecardsPlayerModel>? players,
    bool? started,
    bool? gameOver,
    List<GamePlayingCard>? playedCards,
    List<GamePlayingCard>? deck,
    int? turnIndex,
    double? servedCards,
    bool? served,
  }) {
    return FivecardsGameModel(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      gameType: gameType ?? this.gameType,
      gameMode: gameMode ?? this.gameMode,
      players: players ?? this.players,
      started: started ?? this.started,
      gameOver: gameOver ?? this.gameOver,
      playedCards: playedCards ?? this.playedCards,
      deck: deck ?? this.deck,
      turnIndex: turnIndex ?? this.turnIndex,
      servedCards: servedCards ?? this.servedCards,
      served: served ?? this.served,
    );
  }

  @override
  String toString() {
    return '''
      FivecardsGameModel(
        playedCards: $playedCards, 
        deck: $deck, 
        turnIndex: $turnIndex, 
        numOfPlayers: $numOfPlayers, 
        served: $served
      )
    ''';
  }

  @override
  FivecardsPlayerModel get currentPlayer {
    return players.firstWhere(
      (e) => e.id == profileId,
      orElse: () => FivecardsPlayerModel(
        id: 'No Id',
        username: 'No player',
        index: -1,
      ),
    );
  }

  @override
  FivecardsPlayerModel get winner => players.firstWhere(
        (e) => gameOver && e.cards.isEmpty,
        orElse: () => FivecardsPlayerModel(
          id: 'No Id',
          username: 'No player',
          index: -1,
        ),
      );

  @override
  List<FivecardsPlayerModel> get otherPlayers {
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

  FivecardsGameModel meWithSortedCards() => copyWith(
        players: [
          for (var player in players)
            if (player.index == currentPlayer.index)
              currentPlayer.withSortedCards()
            else
              player
        ],
      );

  FivecardsGameModel serveCards() {
    if (!served) {
      List<FivecardsPlayerModel> players = [];
      shuffleDeck();
      for (FivecardsPlayerModel player in this.players) {
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

  FivecardsGameModel nextPlayState(GamePlayingCard card) {
    FivecardsPlayerModel me = _getCurrentPlayer(card);

    if (me.cards.isEmpty) {
      gameOver = true;
    }

    FivecardsPlayerModel nextPlayer = getNextPlayer(card);

    return copyWith(
      playedCards: [...playedCards, card],
      turnIndex: nextPlayer.index,
      players: [
        for (final player in players)
          if (player.index == nextPlayer.index)
            if (me.index == nextPlayer.index)
              me.copyWith(isTurn: true)
            else
              nextPlayer
          else if (player.index == me.index)
            me
          else
            player
      ],
    );
  }

  FivecardsGameModel nextDeckState() {
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

  FivecardsGameModel nextPlayedCardsState() {
    if (playedCards.isNotEmpty) {
      GamePlayingCard topPlayedCard = playedCards.removeLast();

      return copyWith(
        players: [
          for (var player in players)
            if (player.isTurn)
              player.copyWith(cards: [...player.cards, topPlayedCard])
            else
              player
        ],
      );
    } else {
      return this;
    }
  }

  FivecardsPlayerModel getNextPlayer([GamePlayingCard? card]) {
    return players[_nextIndex].copyWith(
      isTurn: true,
    );
  }

  FivecardsPlayerModel _getCurrentPlayer(GamePlayingCard card) =>
      currentPlayer.copyWith(
        isTurn: false,
        cards: players[_currentIndex].cards.where((e) => e != card).toList(),
      );

  FivecardsPlayerModel get turnPlayer => players[turnIndex];
  int get _currentIndex => turnIndex;
  bool get isMyTurn => currentPlayer.index == turnIndex;
  bool get isWinner => currentPlayer.index == winner.index;
  bool get islastPlayCard => currentPlayer.cards.length == 1;
  int get _nextIndex => (_currentIndex + 1) % numOfPlayers;
  int get deckCount => deck.length;
  int get numOfPlayers => players.length;
}
