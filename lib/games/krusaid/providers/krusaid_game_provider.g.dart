// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'krusaid_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$krusaidGameHash() => r'0be151a4c42badb7c65f5206e8814d19c187dfa6';

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

abstract class _$KrusaidGame
    extends BuildlessAutoDisposeNotifier<KrusaidGameState> {
  late final KrusaidGameModel game;

  KrusaidGameState build(
    KrusaidGameModel game,
  );
}

/// See also [KrusaidGame].
@ProviderFor(KrusaidGame)
const krusaidGameProvider = KrusaidGameFamily();

/// See also [KrusaidGame].
class KrusaidGameFamily extends Family<KrusaidGameState> {
  /// See also [KrusaidGame].
  const KrusaidGameFamily();

  /// See also [KrusaidGame].
  KrusaidGameProvider call(
    KrusaidGameModel game,
  ) {
    return KrusaidGameProvider(
      game,
    );
  }

  @override
  KrusaidGameProvider getProviderOverride(
    covariant KrusaidGameProvider provider,
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
  String? get name => r'krusaidGameProvider';
}

/// See also [KrusaidGame].
class KrusaidGameProvider
    extends AutoDisposeNotifierProviderImpl<KrusaidGame, KrusaidGameState> {
  /// See also [KrusaidGame].
  KrusaidGameProvider(
    KrusaidGameModel game,
  ) : this._internal(
          () => KrusaidGame()..game = game,
          from: krusaidGameProvider,
          name: r'krusaidGameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$krusaidGameHash,
          dependencies: KrusaidGameFamily._dependencies,
          allTransitiveDependencies:
              KrusaidGameFamily._allTransitiveDependencies,
          game: game,
        );

  KrusaidGameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.game,
  }) : super.internal();

  final KrusaidGameModel game;

  @override
  KrusaidGameState runNotifierBuild(
    covariant KrusaidGame notifier,
  ) {
    return notifier.build(
      game,
    );
  }

  @override
  Override overrideWith(KrusaidGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: KrusaidGameProvider._internal(
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
  AutoDisposeNotifierProviderElement<KrusaidGame, KrusaidGameState>
      createElement() {
    return _KrusaidGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is KrusaidGameProvider && other.game == game;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, game.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin KrusaidGameRef on AutoDisposeNotifierProviderRef<KrusaidGameState> {
  /// The parameter `game` of this provider.
  KrusaidGameModel get game;
}

class _KrusaidGameProviderElement
    extends AutoDisposeNotifierProviderElement<KrusaidGame, KrusaidGameState>
    with KrusaidGameRef {
  _KrusaidGameProviderElement(super.provider);

  @override
  KrusaidGameModel get game => (origin as KrusaidGameProvider).game;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
