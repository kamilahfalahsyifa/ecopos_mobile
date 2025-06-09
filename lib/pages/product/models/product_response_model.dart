import 'dart:convert';

class Product {
  final List<ProductElement>? products;
  final String? message;

  Product({
    this.products,
    this.message,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        products: json["products"] == null
            ? []
            : List<ProductElement>.from(
                json["products"]!.map((x) => ProductElement.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "message": message,
      };
}

class ProductElement {
  final String? id;
  final String? outletId;
  final String? categoryId;
  final String? name;
  final int? stock;
  final bool? isNonStock;
  final String? initialPrice;
  final String? sellingPrice;
  final String? unit;
  final String? heroImages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

  ProductElement({
    this.id,
    this.outletId,
    this.categoryId,
    this.name,
    this.stock,
    this.isNonStock,
    this.initialPrice,
    this.sellingPrice,
    this.unit,
    this.heroImages,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory ProductElement.fromRawJson(String str) =>
      ProductElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        outletId: json["outlet_id"],
        categoryId: json["category_id"],
        name: json["name"],
        stock: json["stock"],
        isNonStock: json["is_non_stock"],
        initialPrice: json["initial_price"],
        sellingPrice: json["selling_price"],
        unit: json["unit"],
        heroImages: json["hero_images"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "outlet_id": outletId,
        "category_id": categoryId,
        "name": name,
        "stock": stock,
        "is_non_stock": isNonStock,
        "initial_price": initialPrice,
        "selling_price": sellingPrice,
        "unit": unit,
        "hero_images": heroImages,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
      };
}

class Category {
  final String? id;
  final String? outletId;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.outletId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        outletId: json["outlet_id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "outlet_id": outletId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
