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
final inventoryRawProvider = InventoryRawProvider._();

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
  InventoryRawProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryRawProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryRawHash();

  @$internal
  @override
  $StreamProviderElement<List<Map<String, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Map<String, dynamic>>> create(Ref ref) {
    return inventoryRaw(ref);
  }
}

String _$inventoryRawHash() => r'0467710b5429b42cf11d4f04f121b51113a25e79';

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

String _$inventoryHash() => r'd58dbe2ffa7bff31432e3b73ee324027668d0206';

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
    r'2bc8b0b7a715eaa4650a466c926f9f3bd5d1fd00';
