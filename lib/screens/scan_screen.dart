import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/product.dart';
import '../providers/inventory_provider.dart';
import 'add_product_screen.dart';

enum ScanMode { stockIn, consume }

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  ScanMode _mode = ScanMode.stockIn;
  bool _busy = false;
  String? _lastBarcode;
  String? _feedback;

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_busy) return;
    final barcodes = capture.barcodes;
    final barcode = barcodes.isEmpty ? null : barcodes.first.rawValue;
    if (barcode == null || barcode == _lastBarcode) return;

    setState(() {
      _busy = true;
      _lastBarcode = barcode;
      _feedback = null;
    });

    final notifier = ref.read(inventoryProvider);

    try {
      if (_mode == ScanMode.stockIn) {
        final product = await notifier.lookupProduct(barcode);
        if (product == null) {
          if (!mounted) return;
          final created = await Navigator.push<Product>(
            context,
            MaterialPageRoute(builder: (_) => AddProductScreen(barcode: barcode)),
          );
          if (created != null) {
            await notifier.stockIn(product: created);
            setState(() => _feedback = '${created.name} eingeräumt');
          }
        } else {
          await notifier.stockIn(product: product);
          setState(() => _feedback = '${product.name} eingeräumt');
        }
      } else {
        await notifier.consume(barcode);
        setState(() => _feedback = 'Verbrauch gebucht');
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
        // kurze Sperre, damit derselbe Barcode nicht sofort doppelt erkannt wird
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _lastBarcode = null);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scannen')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<ScanMode>(
              segments: const [
                ButtonSegment(value: ScanMode.stockIn, label: Text('Einräumen')),
                ButtonSegment(value: ScanMode.consume, label: Text('Verbrauchen')),
              ],
              selected: {_mode},
              onSelectionChanged: (s) => setState(() => _mode = s.first),
            ),
          ),
          if (_feedback != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(_feedback!, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          Expanded(
            child: Stack(
              children: [
                MobileScanner(onDetect: _onDetect),
                if (_busy) const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
