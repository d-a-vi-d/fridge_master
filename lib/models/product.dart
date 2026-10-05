class Product {
  final String barcode;
  final String name;
  final String? brand;
  final String? imageUrl;
  final String source; // 'off' oder 'manual'

  Product({
    required this.barcode,
    required this.name,
    this.brand,
    this.imageUrl,
    required this.source,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    barcode: json['barcode'] as String,
    name: json['name'] as String,
    brand: json['brand'] as String?,
    imageUrl: json['image_url'] as String?,
    source: json['source'] as String,
  );

  Map<String, dynamic> toJson() => {
    'barcode': barcode,
    'name': name,
    'brand': brand,
    'image_url': imageUrl,
    'source': source,
  };
}
