import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/product.dart';
import '../providers/scan_provider.dart';
import 'add_product_screen.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final _scanner = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
    ],
  );

  @override
  void dispose() {
    _scanner.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final barcode = capture.barcodes.firstOrNull?.rawValue;
    if (barcode == null) return;

    ref.read(scanProvider.notifier).onBarcode(barcode, onUnknownProduct: _createProduct);
  }

  Future<Product?> _createProduct(String barcode) async {
    await _scanner.stop();
    if (!mounted) return null;

    final product = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (_) => AddProductScreen(barcode: barcode)),
    );

    if (mounted) await _scanner.start();
    return product;
  }

  @override
  Widget build(BuildContext context) {
    final scan = ref.watch(scanProvider);
    final controller = ref.read(scanProvider.notifier);

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
              selected: {scan.mode},
              onSelectionChanged: scan.busy ? null : (s) => controller.setMode(s.first),
            ),
          ),
          if (scan.feedback != null) _FeedbackBanner(feedback: scan.feedback!),
          Expanded(
            child: Stack(
              children: [
                MobileScanner(controller: _scanner, onDetect: _onDetect),
                if (scan.busy) const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({required this.feedback});
  final ScanFeedback feedback;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: feedback.isError ? scheme.errorContainer : scheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        feedback.message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: feedback.isError ? scheme.onErrorContainer : scheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
