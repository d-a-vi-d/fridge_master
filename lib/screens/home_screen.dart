import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/household.dart';
import '../providers/household_provider.dart';
import '../providers/inventory_provider.dart';
import '../widgets/custom_page.dart';
import 'household/household_screen.dart';
import 'scan_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _titleFor(List<Household> households, String? selectedId) {
    for (final h in households) {
      if (h.id == selectedId) return h.name;
    }
    return 'Übersicht';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryAsync = ref.watch(inventoryProvider);
    final householdsAsync = ref.watch(householdsProvider);
    final selectedId = ref.watch(selectedHouseholdIdProvider);

    return CustomPage(
      appBarItem: IconButton(
        icon: const Icon(Icons.home_work_outlined),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdScreen()));
        },
      ),
      title: _titleFor(householdsAsync.value ?? [], selectedId),
      onFabPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreen()));
      },
      scrollable: false,
      child: inventoryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Noch nichts im Bestand'));
          }
          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
