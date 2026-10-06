import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';
import '../models/inventory_item.dart';
import 'household_provider.dart';
import 'products_provider.dart';

part 'inventory_provider.g.dart';

@riverpod
Stream<List<Map<String, dynamic>>> _rawInventory(Ref ref) {
  final householdId = ref.watch(selectedHouseholdIdProvider);
  if (householdId == null) return Stream.value([]);

  return supabase
      .from('inventory_items')
      .stream(primaryKey: ['id'])
      .eq('household_id', householdId)
      .order('updated_at');
}

@riverpod
List<InventoryItem> inventory(Ref ref) {
  final rawRows = ref.watch(_rawInventoryProvider).value ?? [];
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
