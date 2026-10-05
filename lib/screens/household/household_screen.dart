import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/household_provider.dart';

class HouseholdScreen extends ConsumerStatefulWidget {
  const HouseholdScreen({super.key});

  @override
  ConsumerState<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends ConsumerState<HouseholdScreen> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  String? _error;

  Future<void> _create() async {
    if (_nameController.text.trim().isEmpty) return;
    try {
      await ref.read(householdsProvider.notifier).create(_nameController.text.trim());
      _nameController.clear();
      setState(() => _error = null);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _join() async {
    if (_codeController.text.trim().isEmpty) return;
    try {
      await ref.read(householdsProvider.notifier).join(_codeController.text.trim());
      _codeController.clear();
      setState(() => _error = null);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final householdsAsync = ref.watch(householdsProvider);
    final selectedId = ref.watch(selectedHouseholdIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Haushalt')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),

            householdsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Fehler: $e'),
              data: (households) {
                if (households.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Deine Haushalte', style: TextStyle(fontWeight: FontWeight.bold)),
                    ...households.map(
                      (h) => ListTile(
                        title: Text(h.name),
                        subtitle: Text('Code: ${h.inviteCode}'),
                        trailing: h.id == selectedId ? const Icon(Icons.check_circle) : null,
                        onTap: () {
                          ref.read(selectedHouseholdIdProvider.notifier).select(h.id);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),

            const Divider(height: 32),
            const Text('Neuen Haushalt erstellen', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            ElevatedButton(onPressed: _create, child: const Text('Erstellen')),

            const Divider(height: 32),
            const Text('Haushalt beitreten', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Einladungscode'),
              textCapitalization: TextCapitalization.characters,
            ),
            ElevatedButton(onPressed: _join, child: const Text('Beitreten')),
          ],
        ),
      ),
    );
  }
}
