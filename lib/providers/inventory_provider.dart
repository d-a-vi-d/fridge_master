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

// Stream pro Haushalt, keepAlive: wird bei Screenwechseln nicht verworfen
@Riverpod(keepAlive: true)
Stream<List<Map<String, dynamic>>> inventoryRaw(Ref ref, String householdId) {
  return supabase
      .from('inventory_items')
      .stream(primaryKey: ['id'])
      .eq('household_id', householdId)
      .order('updated_at');
}

@riverpod
List<InventoryItem> inventory(Ref ref) {
  final householdId = ref.watch(selectedHouseholdIdProvider);
  if (householdId == null) return [];

  final rawRows = (ref.watch(inventoryRawProvider(householdId)).value ?? []).where(
    (row) => (row['quantity'] as int) > 0,
  ); // verbrauchte Zeilen ausblenden
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
  final householdId = ref.watch(selectedHouseholdIdProvider);
  if (householdId == null) return false;

  final raw = ref.watch(inventoryRawProvider(householdId));
  final products = ref.watch(allProductsProvider);

  // Spinner nur, solange noch gar keine Daten da waren
  return (raw.isLoading && !raw.hasValue) || (products.isLoading && !products.hasValue);
}
