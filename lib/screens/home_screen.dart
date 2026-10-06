import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/household_provider.dart';
import '../providers/inventory_provider.dart';
import '../widgets/custom_page.dart';
import 'household_screen.dart';
import 'scan_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(inventoryProvider);
    final isLoading = ref.watch(inventoryIsLoadingProvider);
    final householdsAsync = ref.watch(householdsProvider);
    final selectedId = ref.watch(selectedHouseholdIdProvider);

    final title =
        householdsAsync.value?.where((h) => h.id == selectedId).map((h) => h.name).firstOrNull ??
        'Übersicht';

    return CustomPage(
      title: title,
      appBarItem: IconButton(
        icon: const Icon(Icons.home_work_outlined),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdScreen()));
        },
      ),
      onFabPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreen()));
      },
      scrollable: false,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
          ? const Center(child: Text('Noch nichts im Bestand'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final item = items[i];
                return ListTile(
                  title: Text(item.product?.name ?? item.barcode),
                  subtitle: item.expiryDate != null
                      ? Text('MHD: ${item.expiryDate!.toLocal().toString().split(' ').first}')
                      : null,
                  trailing: Text('${item.quantity}x'),
                );
              },
            ),
    );
  }
}
