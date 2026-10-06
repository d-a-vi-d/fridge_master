import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/product.dart';
import 'household_provider.dart';
import 'inventory_provider.dart';
import 'products_provider.dart';

part 'scan_provider.g.dart';

enum ScanMode { stockIn, consume }

class ScanFeedback {
  const ScanFeedback(this.message, {this.isError = false});
  final String message;
  final bool isError;
}

class ScanState {
  const ScanState({this.mode = ScanMode.stockIn, this.busy = false, this.feedback});

  final ScanMode mode;
  final bool busy;
  final ScanFeedback? feedback;

  ScanState copyWith({
    ScanMode? mode,
    bool? busy,
    ScanFeedback? feedback,
    bool clearFeedback = false,
  }) => ScanState(
    mode: mode ?? this.mode,
    busy: busy ?? this.busy,
    feedback: clearFeedback ? null : (feedback ?? this.feedback),
  );
}

@riverpod
class Scan extends _$Scan {
  static const _cooldown = Duration(seconds: 2);

  bool _disposed = false;
  String? _lastBarcode;
  DateTime? _lastScanAt;

  @override
  ScanState build() {
    ref.onDispose(() => _disposed = true);
    return const ScanState();
  }

  void setMode(ScanMode mode) => _emit((s) => s.copyWith(mode: mode, clearFeedback: true));

  /// [onUnknownProduct] wird aufgerufen, wenn der Barcode im Einräum-Modus
  /// noch nicht bekannt ist. Gibt das neu angelegte Produkt zurück oder null bei Abbruch.
  Future<void> onBarcode(
    String barcode, {
    required Future<Product?> Function(String barcode) onUnknownProduct,
  }) async {
    if (state.busy || _isDuplicate(barcode)) return;

    _emit((s) => s.copyWith(busy: true, clearFeedback: true));
    try {
      final feedback = await _process(barcode, state.mode, onUnknownProduct);
      if (feedback != null) _emit((s) => s.copyWith(feedback: feedback));
    } catch (e, st) {
      debugPrint('Scan fehlgeschlagen: $e\n$st');
      _emit(
        (s) => s.copyWith(
          feedback: const ScanFeedback(
            'Das hat nicht geklappt. Bitte nochmal versuchen.',
            isError: true,
          ),
        ),
      );
    } finally {
      _lastBarcode = barcode;
      _lastScanAt = DateTime.now();
      _emit((s) => s.copyWith(busy: false));
    }
  }

  Future<ScanFeedback?> _process(
    String barcode,
    ScanMode mode,
    Future<Product?> Function(String barcode) onUnknownProduct,
  ) async {
    final householdId = ref.read(selectedHouseholdIdProvider);
    if (householdId == null) {
      return const ScanFeedback('Kein Haushalt ausgewählt', isError: true);
    }

    final service = ref.read(inventoryServiceProvider);

    switch (mode) {
      case ScanMode.stockIn:
        final product = await service.findLocalProduct(barcode) ?? await onUnknownProduct(barcode);
        if (product == null) return null; // Anlegen abgebrochen

        await service.stockIn(householdId: householdId, product: product);
        final name = ref.read(mergedProductsProvider)[barcode]?.name ?? product.name;
        return ScanFeedback('$name eingeräumt');

      case ScanMode.consume:
        final consumed = await service.consume(householdId, barcode);
        final name = ref.read(mergedProductsProvider)[barcode]?.name ?? barcode;
        return consumed
            ? ScanFeedback('$name verbraucht')
            : ScanFeedback('$name ist nicht im Bestand', isError: true);
    }
  }

  bool _isDuplicate(String barcode) {
    final last = _lastScanAt;
    return barcode == _lastBarcode && last != null && DateTime.now().difference(last) < _cooldown;
  }

  void _emit(ScanState Function(ScanState s) update) {
    if (!_disposed) state = update(state);
  }
}
