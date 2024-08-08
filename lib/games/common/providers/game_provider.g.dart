// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameHash() => r'ae783de579d2d2954bccbebbf8e6465017c636f0';

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

abstract class _$Game extends BuildlessAutoDisposeStreamNotifier<GameModel> {
  late final String? channel;

  Stream<GameModel> build([
    String? channel,
  ]);
}

/// See also [Game].
@ProviderFor(Game)
const gameProvider = GameFamily();

/// See also [Game].
class GameFamily extends Family<AsyncValue<GameModel>> {
  /// See also [Game].
  const GameFamily();

  /// See also [Game].
  GameProvider call([
    String? channel,
  ]) {
    return GameProvider(
      channel,
    );
  }

  @override
  GameProvider getProviderOverride(
    covariant GameProvider provider,
  ) {
    return call(
      provider.channel,
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
  String? get name => r'gameProvider';
}

/// See also [Game].
class GameProvider
    extends AutoDisposeStreamNotifierProviderImpl<Game, GameModel> {
  /// See also [Game].
  GameProvider([
    String? channel,
  ]) : this._internal(
          () => Game()..channel = channel,
          from: gameProvider,
          name: r'gameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$gameHash,
          dependencies: GameFamily._dependencies,
          allTransitiveDependencies: GameFamily._allTransitiveDependencies,
          channel: channel,
        );

  GameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channel,
  }) : super.internal();

  final String? channel;

  @override
  Stream<GameModel> runNotifierBuild(
    covariant Game notifier,
  ) {
    return notifier.build(
      channel,
    );
  }

  @override
  Override overrideWith(Game Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameProvider._internal(
        () => create()..channel = channel,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channel: channel,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<Game, GameModel> createElement() {
    return _GameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameProvider && other.channel == channel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameRef on AutoDisposeStreamNotifierProviderRef<GameModel> {
  /// The parameter `channel` of this provider.
  String? get channel;
}

class _GameProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Game, GameModel>
    with GameRef {
  _GameProviderElement(super.provider);

  @override
  String? get channel => (origin as GameProvider).channel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
