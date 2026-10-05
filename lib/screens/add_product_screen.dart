import 'package:flutter/material.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  final String barcode;
  const AddProductScreen({super.key, required this.barcode});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produkt anlegen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Barcode: ${widget.barcode}'),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Marke (optional)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.trim().isEmpty) return;
                Navigator.pop(
                  context,
                  Product(
                    barcode: widget.barcode,
                    name: _nameController.text.trim(),
                    brand: _brandController.text.trim().isEmpty
                        ? null
                        : _brandController.text.trim(),
                    source: 'manual',
                  ),
                );
              },
              child: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
