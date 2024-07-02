// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_methods_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatMethodsHash() => r'd253c3a13624075e5b6e727ab53e62f1b0ed0e79';

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

/// See also [chatMethods].
@ProviderFor(chatMethods)
const chatMethodsProvider = ChatMethodsFamily();

/// See also [chatMethods].
class ChatMethodsFamily extends Family<ChatMethods> {
  /// See also [chatMethods].
  const ChatMethodsFamily();

  /// See also [chatMethods].
  ChatMethodsProvider call(
    SupabaseChatController controller,
    Room room,
  ) {
    return ChatMethodsProvider(
      controller,
      room,
    );
  }

  @override
  ChatMethodsProvider getProviderOverride(
    covariant ChatMethodsProvider provider,
  ) {
    return call(
      provider.controller,
      provider.room,
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
  String? get name => r'chatMethodsProvider';
}

/// See also [chatMethods].
class ChatMethodsProvider extends AutoDisposeProvider<ChatMethods> {
  /// See also [chatMethods].
  ChatMethodsProvider(
    SupabaseChatController controller,
    Room room,
  ) : this._internal(
          (ref) => chatMethods(
            ref as ChatMethodsRef,
            controller,
            room,
          ),
          from: chatMethodsProvider,
          name: r'chatMethodsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatMethodsHash,
          dependencies: ChatMethodsFamily._dependencies,
          allTransitiveDependencies:
              ChatMethodsFamily._allTransitiveDependencies,
          controller: controller,
          room: room,
        );

  ChatMethodsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.controller,
    required this.room,
  }) : super.internal();

  final SupabaseChatController controller;
  final Room room;

  @override
  Override overrideWith(
    ChatMethods Function(ChatMethodsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatMethodsProvider._internal(
        (ref) => create(ref as ChatMethodsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        controller: controller,
        room: room,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ChatMethods> createElement() {
    return _ChatMethodsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMethodsProvider &&
        other.controller == controller &&
        other.room == room;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, controller.hashCode);
    hash = _SystemHash.combine(hash, room.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatMethodsRef on AutoDisposeProviderRef<ChatMethods> {
  /// The parameter `controller` of this provider.
  SupabaseChatController get controller;

  /// The parameter `room` of this provider.
  Room get room;
}

class _ChatMethodsProviderElement
    extends AutoDisposeProviderElement<ChatMethods> with ChatMethodsRef {
  _ChatMethodsProviderElement(super.provider);

  @override
  SupabaseChatController get controller =>
      (origin as ChatMethodsProvider).controller;
  @override
  Room get room => (origin as ChatMethodsProvider).room;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
