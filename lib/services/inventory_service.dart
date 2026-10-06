import '../main.dart';
import '../models/product.dart';

class InventoryService {
  Future<Product?> findLocalProduct(String barcode) async {
    final res = await supabase.from('products').select().eq('barcode', barcode).maybeSingle();
    return res == null ? null : Product.fromJson(res);
  }

  Future<void> upsertProduct(Product product) async {
    await supabase.from('products').upsert(product.toJson());
  }

  Future<void> stockIn({
    required String householdId,
    required Product product,
    DateTime? expiryDate,
  }) async {
    await upsertProduct(product);
    await supabase.from('inventory_items').insert({
      'household_id': householdId,
      'barcode': product.barcode,
      'quantity': 1,
      'expiry_date': expiryDate?.toIso8601String(),
    });
  }

  Future<bool> consume(String householdId, String barcode) async {
    final rows = await supabase
        .from('inventory_items')
        .select('id, quantity')
        .eq('household_id', householdId)
        .eq('barcode', barcode)
        .order('expiry_date', ascending: true, nullsFirst: false)
        .limit(1);

    if (rows.isEmpty) return false;

    final row = rows.first;
    final id = row['id'] as String;
    final qty = row['quantity'] as int;

    if (qty <= 1) {
      await supabase.from('inventory_items').delete().eq('id', id);
    } else {
      await supabase.from('inventory_items').update({'quantity': qty - 1}).eq('id', id);
    }
    return true;
  }

  Future<void> setHouseholdLabel({
    required String householdId,
    required String barcode,
    String? customName,
    String? customBrand,
  }) async {
    await supabase.from('household_product_labels').upsert({
      'household_id': householdId,
      'barcode': barcode,
      'custom_name': customName,
      'custom_brand': customBrand,
    });
  }
}
