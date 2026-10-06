// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Alle globalen Produktstammdaten, barcode → Product.

@ProviderFor(allProducts)
final allProductsProvider = AllProductsProvider._();

/// Alle globalen Produktstammdaten, barcode → Product.

final class AllProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Product>>,
          Map<String, Product>,
          Stream<Map<String, Product>>
        >
    with
        $FutureModifier<Map<String, Product>>,
        $StreamProvider<Map<String, Product>> {
  /// Alle globalen Produktstammdaten, barcode → Product.
  AllProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allProductsHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, Product>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, Product>> create(Ref ref) {
    return allProducts(ref);
  }
}

String _$allProductsHash() => r'3c34ed2e25c8761fd4dbf9de4081b5b4cd43a8e8';

/// Haushaltsspezifische Namens-Overrides, barcode → (name, brand).

@ProviderFor(householdLabels)
final householdLabelsProvider = HouseholdLabelsProvider._();

/// Haushaltsspezifische Namens-Overrides, barcode → (name, brand).

final class HouseholdLabelsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, ({String? brand, String? name})>>,
          Map<String, ({String? brand, String? name})>,
          Stream<Map<String, ({String? brand, String? name})>>
        >
    with
        $FutureModifier<Map<String, ({String? brand, String? name})>>,
        $StreamProvider<Map<String, ({String? brand, String? name})>> {
  /// Haushaltsspezifische Namens-Overrides, barcode → (name, brand).
  HouseholdLabelsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'householdLabelsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$householdLabelsHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, ({String? brand, String? name})>>
  $createElement($ProviderPointer pointer) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, ({String? brand, String? name})>> create(Ref ref) {
    return householdLabels(ref);
  }
}

String _$householdLabelsHash() => r'e078248cc55b9d893517595e7cf110542ae234c9';

/// Fertig gemergte Produktliste: globaler Name, haushaltsspezifisch überschrieben wo vorhanden.

@ProviderFor(mergedProducts)
final mergedProductsProvider = MergedProductsProvider._();

/// Fertig gemergte Produktliste: globaler Name, haushaltsspezifisch überschrieben wo vorhanden.

final class MergedProductsProvider
    extends
        $FunctionalProvider<
          Map<String, Product>,
          Map<String, Product>,
          Map<String, Product>
        >
    with $Provider<Map<String, Product>> {
  /// Fertig gemergte Produktliste: globaler Name, haushaltsspezifisch überschrieben wo vorhanden.
  MergedProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mergedProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mergedProductsHash();

  @$internal
  @override
  $ProviderElement<Map<String, Product>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, Product> create(Ref ref) {
    return mergedProducts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Product> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Product>>(value),
    );
  }
}

String _$mergedProductsHash() => r'11e1ab21be2e6ca0cbcefedfd343b7becd2ce4ce';
