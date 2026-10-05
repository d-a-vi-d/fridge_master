import 'package:fridge_master/models/product.dart';

class InventoryItem {
  final String id;
  final String barcode;
  final int quantity;
  final DateTime? expiryDate;
  final Product? product; // aus dem Join, optional

  InventoryItem({
    required this.id,
    required this.barcode,
    required this.quantity,
    this.expiryDate,
    this.product,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
    id: json['id'] as String,
    barcode: json['barcode'] as String,
    quantity: json['quantity'] as int,
    expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date'] as String) : null,
    product: json['products'] != null
        ? Product.fromJson(json['products'] as Map<String, dynamic>)
        : null,
  );
}
