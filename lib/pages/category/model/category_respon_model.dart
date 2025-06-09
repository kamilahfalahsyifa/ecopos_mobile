import 'dart:convert';

class Categories {
    final List<Category>? categories;
    final String? message;

    Categories({
        this.categories,
        this.message,
    });

    factory Categories.fromRawJson(String str) => Categories.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "message": message,
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

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        outletId: json["outlet_id"],
        name: json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "outlet_id": outletId,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
