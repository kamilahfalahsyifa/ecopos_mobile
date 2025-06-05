class Product {
  final String? id;
  final String name;
  final int selling_price;
  final String category_id;
  final String outlet_id;
  final int stock;
  final bool is_non_stock;
  final int initial_price;
  final String unit;
  final String hero_images; // bisa path lokal atau URL

  Product({
    this.id,
    required this.name,
    required this.selling_price,
    required this.category_id,
    required this.outlet_id,
    required this.stock,
    required this.is_non_stock,
    required this.initial_price,
    required this.unit,
    required this.hero_images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'].toString(),
    name: json['name'],
    selling_price: int.parse(json['selling_price'].toString()),
    category_id: json['category_id'],
    outlet_id: json['outlet_id'],
    stock: json['stock'],
    is_non_stock: json['is_non_stock'],
    initial_price: int.parse(json['initial_price'].toString()),
    unit: json['unit'],
    hero_images: json['hero_images'],
  );
}

}
