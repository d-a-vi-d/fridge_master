// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inventoryService)
final inventoryServiceProvider = InventoryServiceProvider._();

final class InventoryServiceProvider
    extends
        $FunctionalProvider<
          InventoryService,
          InventoryService,
          InventoryService
        >
    with $Provider<InventoryService> {
  InventoryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryServiceHash();

  @$internal
  @override
  $ProviderElement<InventoryService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InventoryService create(Ref ref) {
    return inventoryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InventoryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InventoryService>(value),
    );
  }
}

String _$inventoryServiceHash() => r'f8b33210475b8b2b25dae3b2829d303b4bdbd85c';

@ProviderFor(inventoryRaw)
final inventoryRawProvider = InventoryRawFamily._();

final class InventoryRawProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Map<String, dynamic>>>,
          List<Map<String, dynamic>>,
          Stream<List<Map<String, dynamic>>>
        >
    with
        $FutureModifier<List<Map<String, dynamic>>>,
        $StreamProvider<List<Map<String, dynamic>>> {
  InventoryRawProvider._({
    required InventoryRawFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'inventoryRawProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inventoryRawHash();

  @override
  String toString() {
    return r'inventoryRawProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as String;
    return inventoryRaw(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InventoryRawProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inventoryRawHash() => r'05e3fe15041f8f35664d6d9149cb3b096b73b95a';

final class InventoryRawFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Map<String, dynamic>>>, String> {
  InventoryRawFamily._()
    : super(
        retry: null,
        name: r'inventoryRawProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  InventoryRawProvider call(String householdId) =>
      InventoryRawProvider._(argument: householdId, from: this);

  @override
  String toString() => r'inventoryRawProvider';
}

@ProviderFor(inventory)
final inventoryProvider = InventoryProvider._();

final class InventoryProvider
    extends
        $FunctionalProvider<
          List<InventoryItem>,
          List<InventoryItem>,
          List<InventoryItem>
        >
    with $Provider<List<InventoryItem>> {
  InventoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryHash();

  @$internal
  @override
  $ProviderElement<List<InventoryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<InventoryItem> create(Ref ref) {
    return inventory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<InventoryItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<InventoryItem>>(value),
    );
  }
}

String _$inventoryHash() => r'ac6c659ba407f4030002e612ddddd5e779d88d6e';

@ProviderFor(inventoryIsLoading)
final inventoryIsLoadingProvider = InventoryIsLoadingProvider._();

final class InventoryIsLoadingProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  InventoryIsLoadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryIsLoadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryIsLoadingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return inventoryIsLoading(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$inventoryIsLoadingHash() =>
    r'd60c5462b420c95a594d060a6edbd996b438057b';
