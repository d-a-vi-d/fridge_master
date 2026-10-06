import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';
import '../models/inventory_item.dart';
import '../services/inventory_service.dart';
import 'household_provider.dart';
import 'products_provider.dart';

part 'inventory_provider.g.dart';

// --- Schreibzugriff ---

@riverpod
InventoryService inventoryService(Ref ref) => InventoryService();

// --- Lesezugriff (Realtime) ---

@riverpod
Stream<List<Map<String, dynamic>>> inventoryRaw(Ref ref) {
  final householdId = ref.watch(selectedHouseholdIdProvider);
  if (householdId == null) return Stream.value([]);

  return supabase
      .from('inventory_items')
      .stream(primaryKey: ['id'])
      .eq('household_id', householdId)
      .order('updated_at');
}

// --- Abgeleitet ---

@riverpod
List<InventoryItem> inventory(Ref ref) {
  final rawRows = ref.watch(inventoryRawProvider).value ?? [];
  final products = ref.watch(mergedProductsProvider);

  return rawRows.map((row) {
    final barcode = row['barcode'] as String;
    return InventoryItem(
      id: row['id'] as String,
      barcode: barcode,
      quantity: row['quantity'] as int,
      expiryDate: row['expiry_date'] != null ? DateTime.parse(row['expiry_date'] as String) : null,
      product: products[barcode],
    );
  }).toList();
}

@riverpod
bool inventoryIsLoading(Ref ref) {
  final rawLoading = ref.watch(inventoryRawProvider).isLoading;
  final productsLoading = ref.watch(allProductsProvider).isLoading;
  return rawLoading || productsLoading;
}
