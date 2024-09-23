// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morabaraba_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$morabarabaGameHash() => r'59b3ba6e713f7c20b11054ae22d69b07c7da03e8';

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

abstract class _$MorabarabaGame
    extends BuildlessAutoDisposeNotifier<MorabarabaGameModel> {
  late final MorabarabaGameOptions options;

  MorabarabaGameModel build(
    MorabarabaGameOptions options,
  );
}

/// See also [MorabarabaGame].
@ProviderFor(MorabarabaGame)
const morabarabaGameProvider = MorabarabaGameFamily();

/// See also [MorabarabaGame].
class MorabarabaGameFamily extends Family<MorabarabaGameModel> {
  /// See also [MorabarabaGame].
  const MorabarabaGameFamily();

  /// See also [MorabarabaGame].
  MorabarabaGameProvider call(
    MorabarabaGameOptions options,
  ) {
    return MorabarabaGameProvider(
      options,
    );
  }

  @override
  MorabarabaGameProvider getProviderOverride(
    covariant MorabarabaGameProvider provider,
  ) {
    return call(
      provider.options,
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
  String? get name => r'morabarabaGameProvider';
}

/// See also [MorabarabaGame].
class MorabarabaGameProvider extends AutoDisposeNotifierProviderImpl<
    MorabarabaGame, MorabarabaGameModel> {
  /// See also [MorabarabaGame].
  MorabarabaGameProvider(
    MorabarabaGameOptions options,
  ) : this._internal(
          () => MorabarabaGame()..options = options,
          from: morabarabaGameProvider,
          name: r'morabarabaGameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$morabarabaGameHash,
          dependencies: MorabarabaGameFamily._dependencies,
          allTransitiveDependencies:
              MorabarabaGameFamily._allTransitiveDependencies,
          options: options,
        );

  MorabarabaGameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.options,
  }) : super.internal();

  final MorabarabaGameOptions options;

  @override
  MorabarabaGameModel runNotifierBuild(
    covariant MorabarabaGame notifier,
  ) {
    return notifier.build(
      options,
    );
  }

  @override
  Override overrideWith(MorabarabaGame Function() create) {
    return ProviderOverride(
      origin: this,
      override: MorabarabaGameProvider._internal(
        () => create()..options = options,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        options: options,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MorabarabaGame, MorabarabaGameModel>
      createElement() {
    return _MorabarabaGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MorabarabaGameProvider && other.options == options;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, options.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MorabarabaGameRef on AutoDisposeNotifierProviderRef<MorabarabaGameModel> {
  /// The parameter `options` of this provider.
  MorabarabaGameOptions get options;
}

class _MorabarabaGameProviderElement extends AutoDisposeNotifierProviderElement<
    MorabarabaGame, MorabarabaGameModel> with MorabarabaGameRef {
  _MorabarabaGameProviderElement(super.provider);

  @override
  MorabarabaGameOptions get options =>
      (origin as MorabarabaGameProvider).options;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
