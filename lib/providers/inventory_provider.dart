import '../models/inventory_item.dart';
import '../models/product.dart';
import '../services/inventory_service.dart';
import '../services/off_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'household_provider.dart';

part 'inventory_provider.g.dart';

final _inventoryService = InventoryService();
final _offService = OffService();

@riverpod
class Inventory extends _$Inventory {
  @override
  Future<List<InventoryItem>> build() async {
    final householdId = ref.watch(selectedHouseholdIdProvider);
    if (householdId == null) return [];
    return _inventoryService.getInventory(householdId);
  }

  Future<void> refresh() async {
    final householdId = ref.read(selectedHouseholdIdProvider);
    if (householdId == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _inventoryService.getInventory(householdId));
  }

  Future<Product?> lookupProduct(String barcode) async {
    final local = await _inventoryService.getProduct(barcode);
    if (local != null) return local;
    return _offService.lookup(barcode);
  }

  Future<void> stockIn({required Product product, DateTime? expiryDate}) async {
    final householdId = ref.read(selectedHouseholdIdProvider);
    if (householdId == null) return;
    await _inventoryService.upsertProduct(product);
    await _inventoryService.addItem(
      householdId: householdId,
      barcode: product.barcode,
      expiryDate: expiryDate,
    );
    await refresh();
  }

  Future<void> consume(String barcode) async {
    final householdId = ref.read(selectedHouseholdIdProvider);
    if (householdId == null) return;
    await _inventoryService.consumeOne(householdId, barcode);
    await refresh();
  }
}
