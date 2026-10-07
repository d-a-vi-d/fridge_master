import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';
import '../models/product.dart';
import 'household_provider.dart';

part 'products_provider.g.dart';

/// Alle globalen Produktstammdaten, barcode → Product.
@riverpod
Stream<Map<String, Product>> allProducts(Ref ref) {
  return supabase.from('products').stream(primaryKey: ['barcode']).map((rows) {
    debugPrint(
      '[allProducts] Emission: ${rows.length} Zeilen, zuletzt: ${rows.isNotEmpty ? rows.last : "-"}',
    );
    return {for (final r in rows) r['barcode'] as String: Product.fromJson(r)};
  });
}

/// Haushaltsspezifische Namens-Overrides, barcode → (name, brand).
@riverpod
Stream<Map<String, ({String? name, String? brand})>> householdLabels(Ref ref) {
  final householdId = ref.watch(selectedHouseholdIdProvider);
  if (householdId == null) return Stream.value({});

  return supabase
      .from('household_product_labels')
      .stream(primaryKey: ['household_id', 'barcode'])
      .eq('household_id', householdId)
      .map(
        (rows) => {
          for (final r in rows)
            r['barcode'] as String: (
              name: r['custom_name'] as String?,
              brand: r['custom_brand'] as String?,
            ),
        },
      );
}

/// Fertig gemergte Produktliste: globaler Name, haushaltsspezifisch überschrieben wo vorhanden.
@riverpod
Map<String, Product> mergedProducts(Ref ref) {
  final products = ref.watch(allProductsProvider).value ?? {};
  final labels = ref.watch(householdLabelsProvider).value ?? {};

  return products.map((barcode, product) {
    final label = labels[barcode];
    if (label == null) return MapEntry(barcode, product);
    return MapEntry(barcode, product.withLabel(customName: label.name, customBrand: label.brand));
  });
}
