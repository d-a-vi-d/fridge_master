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
        isAutoDispose: false,
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

String _$allProductsHash() => r'241a21c35564d4c3648173b8b0a01baf9e4992c9';

@ProviderFor(householdLabels)
final householdLabelsProvider = HouseholdLabelsFamily._();

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
  HouseholdLabelsProvider._({
    required HouseholdLabelsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'householdLabelsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$householdLabelsHash();

  @override
  String toString() {
    return r'householdLabelsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Map<String, ({String? brand, String? name})>>
  $createElement($ProviderPointer pointer) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, ({String? brand, String? name})>> create(Ref ref) {
    final argument = this.argument as String;
    return householdLabels(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HouseholdLabelsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$householdLabelsHash() => r'f10a28bb03035e16c8d24cc93eb69abd0595bae8';

final class HouseholdLabelsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<Map<String, ({String? brand, String? name})>>,
          String
        > {
  HouseholdLabelsFamily._()
    : super(
        retry: null,
        name: r'householdLabelsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  HouseholdLabelsProvider call(String householdId) =>
      HouseholdLabelsProvider._(argument: householdId, from: this);

  @override
  String toString() => r'householdLabelsProvider';
}

@ProviderFor(mergedProducts)
final mergedProductsProvider = MergedProductsProvider._();

final class MergedProductsProvider
    extends
        $FunctionalProvider<
          Map<String, Product>,
          Map<String, Product>,
          Map<String, Product>
        >
    with $Provider<Map<String, Product>> {
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

String _$mergedProductsHash() => r'3257784ef98cfcb739465f9745b9d7ab9b10bb10';
