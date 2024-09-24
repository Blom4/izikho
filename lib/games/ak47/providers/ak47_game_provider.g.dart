// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ak47_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ak47GameHash() => r'0ad1f901c4ab08534d80d2d02da7fc09db7129d7';

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

abstract class _$Ak47Game extends BuildlessAutoDisposeNotifier<Ak47GameState> {
  late final Ak47GameModel game;

  Ak47GameState build(
    Ak47GameModel game,
  );
}

/// See also [Ak47Game].
@ProviderFor(Ak47Game)
const ak47GameProvider = Ak47GameFamily();

/// See also [Ak47Game].
class Ak47GameFamily extends Family<Ak47GameState> {
  /// See also [Ak47Game].
  const Ak47GameFamily();

  /// See also [Ak47Game].
  Ak47GameProvider call(
    Ak47GameModel game,
  ) {
    return Ak47GameProvider(
      game,
    );
  }

  @override
  Ak47GameProvider getProviderOverride(
    covariant Ak47GameProvider provider,
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
  String? get name => r'ak47GameProvider';
}

/// See also [Ak47Game].
class Ak47GameProvider
    extends AutoDisposeNotifierProviderImpl<Ak47Game, Ak47GameState> {
  /// See also [Ak47Game].
  Ak47GameProvider(
    Ak47GameModel game,
  ) : this._internal(
          () => Ak47Game()..game = game,
          from: ak47GameProvider,
          name: r'ak47GameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ak47GameHash,
          dependencies: Ak47GameFamily._dependencies,
          allTransitiveDependencies: Ak47GameFamily._allTransitiveDependencies,
          game: game,
        );

  Ak47GameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.game,
  }) : super.internal();

  final Ak47GameModel game;

  @override
  Ak47GameState runNotifierBuild(
    covariant Ak47Game notifier,
  ) {
    return notifier.build(
      game,
    );
  }

  @override
  Override overrideWith(Ak47Game Function() create) {
    return ProviderOverride(
      origin: this,
      override: Ak47GameProvider._internal(
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
  AutoDisposeNotifierProviderElement<Ak47Game, Ak47GameState> createElement() {
    return _Ak47GameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is Ak47GameProvider && other.game == game;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, game.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin Ak47GameRef on AutoDisposeNotifierProviderRef<Ak47GameState> {
  /// The parameter `game` of this provider.
  Ak47GameModel get game;
}

class _Ak47GameProviderElement
    extends AutoDisposeNotifierProviderElement<Ak47Game, Ak47GameState>
    with Ak47GameRef {
  _Ak47GameProviderElement(super.provider);

  @override
  Ak47GameModel get game => (origin as Ak47GameProvider).game;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
