import '../main.dart';
import '../models/product.dart';
import '../models/inventory_item.dart';

class InventoryService {
  Future<Product?> getProduct(String barcode) async {
    final res = await supabase.from('products').select().eq('barcode', barcode).maybeSingle();
    if (res == null) return null;
    return Product.fromJson(res);
  }

  Future<void> upsertProduct(Product product) async {
    await supabase.from('products').upsert(product.toJson());
  }

  Future<List<InventoryItem>> getInventory(String householdId) async {
    final res = await supabase
        .from('inventory_items')
        .select('*, products(*)')
        .eq('household_id', householdId)
        .order('updated_at', ascending: false);
    return (res as List).map((e) => InventoryItem.fromJson(e)).toList();
  }

  Future<void> addItem({
    required String householdId,
    required String barcode,
    DateTime? expiryDate,
  }) async {
    await supabase.from('inventory_items').insert({
      'household_id': householdId,
      'barcode': barcode,
      'quantity': 1,
      'expiry_date': expiryDate?.toIso8601String(),
    });
  }

  Future<void> consumeOne(String householdId, String barcode) async {
    final rows = await supabase
        .from('inventory_items')
        .select('id, quantity')
        .eq('household_id', householdId)
        .eq('barcode', barcode)
        .order('expiry_date', ascending: true, nullsFirst: false)
        .limit(1);

    if ((rows as List).isEmpty) return;
    final row = rows.first;
    final id = row['id'] as String;
    final qty = row['quantity'] as int;

    if (qty <= 1) {
      await supabase.from('inventory_items').delete().eq('id', id);
    } else {
      await supabase.from('inventory_items').update({'quantity': qty - 1}).eq('id', id);
    }
  }
}
