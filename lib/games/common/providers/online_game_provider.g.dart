// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onlineGameHash() => r'9e5cfbc949d7e573cd9d0fa055ab7e3c80aae296';

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

abstract class _$OnlineGame
    extends BuildlessAutoDisposeStreamNotifier<GameModel> {
  late final String? channel;

  Stream<GameModel> build([
    String? channel,
  ]);
}

/// See also [OnlineGame].
@ProviderFor(OnlineGame)
const onlineGameProvider = OnlineGameFamily();

/// See also [OnlineGame].
class OnlineGameFamily extends Family<AsyncValue<GameModel>> {
  /// See also [OnlineGame].
  const OnlineGameFamily();

  /// See also [OnlineGame].
  OnlineGameProvider call([
    String? channel,
  ]) {
    return OnlineGameProvider(
      channel,
    );
  }

  @override
  OnlineGameProvider getProviderOverride(
    covariant OnlineGameProvider provider,
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
  String? get name => r'onlineGameProvider';
}

/// See also [OnlineGame].
class OnlineGameProvider
    extends AutoDisposeStreamNotifierProviderImpl<OnlineGame, GameModel> {
  /// See also [OnlineGame].
  OnlineGameProvider([
    String? channel,
  ]) : this._internal(
          () => OnlineGame()..channel = channel,
          from: onlineGameProvider,
          name: r'onlineGameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$onlineGameHash,
          dependencies: OnlineGameFamily._dependencies,
          allTransitiveDependencies:
              OnlineGameFamily._allTransitiveDependencies,
          channel: channel,
        );

  OnlineGameProvider._internal(
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
    covariant OnlineGame notifier,
  ) {
    return notifier.build(
      channel,
    );
  }

  @override
  Override overrideWith(OnlineGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: OnlineGameProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<OnlineGame, GameModel>
      createElement() {
    return _OnlineGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnlineGameProvider && other.channel == channel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channel.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OnlineGameRef on AutoDisposeStreamNotifierProviderRef<GameModel> {
  /// The parameter `channel` of this provider.
  String? get channel;
}

class _OnlineGameProviderElement
    extends AutoDisposeStreamNotifierProviderElement<OnlineGame, GameModel>
    with OnlineGameRef {
  _OnlineGameProviderElement(super.provider);

  @override
  String? get channel => (origin as OnlineGameProvider).channel;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
