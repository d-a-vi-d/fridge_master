import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class OffService {
  Future<Product?> lookup(String barcode) async {
    final uri = Uri.parse(
      'https://world.openfoodfacts.org/api/v2/product/$barcode.json?fields=product_name,brands,image_url',
    );
    final res = await http.get(uri);
    if (res.statusCode != 200) return null;

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    if (data['status'] != 1) return null; // nicht gefunden

    final product = data['product'] as Map<String, dynamic>;
    final name = product['product_name'] as String?;
    if (name == null || name.isEmpty) return null;

    return Product(
      barcode: barcode,
      name: name,
      brand: product['brands'] as String?,
      imageUrl: product['image_url'] as String?,
      source: 'off',
    );
  }
}
