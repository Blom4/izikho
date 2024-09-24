// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fivecards_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fivecardsGameHash() => r'5b8fbc712928f1fa916afee629fd9e15154df400';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$FivecardsGame
    extends BuildlessAutoDisposeNotifier<FivecardsGameState> {
  late final FivecardsGameModel game;

  FivecardsGameState build(
    FivecardsGameModel game,
  );
}

/// See also [FivecardsGame].
@ProviderFor(FivecardsGame)
const fivecardsGameProvider = FivecardsGameFamily();

/// See also [FivecardsGame].
class FivecardsGameFamily extends Family<FivecardsGameState> {
  /// See also [FivecardsGame].
  const FivecardsGameFamily();

  /// See also [FivecardsGame].
  FivecardsGameProvider call(
    FivecardsGameModel game,
  ) {
    return FivecardsGameProvider(
      game,
    );
  }

  @override
  FivecardsGameProvider getProviderOverride(
    covariant FivecardsGameProvider provider,
  ) {
    return call(
      provider.game,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fivecardsGameProvider';
}

/// See also [FivecardsGame].
class FivecardsGameProvider
    extends AutoDisposeNotifierProviderImpl<FivecardsGame, FivecardsGameState> {
  /// See also [FivecardsGame].
  FivecardsGameProvider(
    FivecardsGameModel game,
  ) : this._internal(
          () => FivecardsGame()..game = game,
          from: fivecardsGameProvider,
          name: r'fivecardsGameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fivecardsGameHash,
          dependencies: FivecardsGameFamily._dependencies,
          allTransitiveDependencies:
              FivecardsGameFamily._allTransitiveDependencies,
          game: game,
        );

  FivecardsGameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.game,
  }) : super.internal();

  final FivecardsGameModel game;

  @override
  FivecardsGameState runNotifierBuild(
    covariant FivecardsGame notifier,
  ) {
    return notifier.build(
      game,
    );
  }

  @override
  Override overrideWith(FivecardsGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: FivecardsGameProvider._internal(
        () => create()..game = game,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        game: game,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FivecardsGame, FivecardsGameState>
      createElement() {
    return _FivecardsGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FivecardsGameProvider && other.game == game;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, game.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FivecardsGameRef on AutoDisposeNotifierProviderRef<FivecardsGameState> {
  /// The parameter `game` of this provider.
  FivecardsGameModel get game;
}

class _FivecardsGameProviderElement extends AutoDisposeNotifierProviderElement<
    FivecardsGame, FivecardsGameState> with FivecardsGameRef {
  _FivecardsGameProviderElement(super.provider);

  @override
  FivecardsGameModel get game => (origin as FivecardsGameProvider).game;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
