// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_online_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameOnlineHash() => r'2ebb32ef7d49628efefe79bcaf93c1c8b137a8de';

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

abstract class _$GameOnline
    extends BuildlessAutoDisposeStreamNotifier<GameModel> {
  late final String? channel;

  Stream<GameModel> build([
    String? channel,
  ]);
}

/// See also [GameOnline].
@ProviderFor(GameOnline)
const gameOnlineProvider = GameOnlineFamily();

/// See also [GameOnline].
class GameOnlineFamily extends Family<AsyncValue<GameModel>> {
  /// See also [GameOnline].
  const GameOnlineFamily();

  /// See also [GameOnline].
  GameOnlineProvider call([
    String? channel,
  ]) {
    return GameOnlineProvider(
      channel,
    );
  }

  @override
  GameOnlineProvider getProviderOverride(
    covariant GameOnlineProvider provider,
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
  String? get name => r'gameOnlineProvider';
}

/// See also [GameOnline].
class GameOnlineProvider
    extends AutoDisposeStreamNotifierProviderImpl<GameOnline, GameModel> {
  /// See also [GameOnline].
  GameOnlineProvider([
    String? channel,
  ]) : this._internal(
          () => GameOnline()..channel = channel,
          from: gameOnlineProvider,
          name: r'gameOnlineProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameOnlineHash,
          dependencies: GameOnlineFamily._dependencies,
          allTransitiveDependencies:
              GameOnlineFamily._allTransitiveDependencies,
          channel: channel,
        );

  GameOnlineProvider._internal(
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
    covariant GameOnline notifier,
  ) {
    return notifier.build(
      channel,
    );
  }

  @override
  Override overrideWith(GameOnline Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameOnlineProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<GameOnline, GameModel>
      createElement() {
    return _GameOnlineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameOnlineProvider && other.channel == channel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameOnlineRef on AutoDisposeStreamNotifierProviderRef<GameModel> {
  /// The parameter `channel` of this provider.
  String? get channel;
}

class _GameOnlineProviderElement
    extends AutoDisposeStreamNotifierProviderElement<GameOnline, GameModel>
    with GameOnlineRef {
  _GameOnlineProviderElement(super.provider);

  @override
  String? get channel => (origin as GameOnlineProvider).channel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
