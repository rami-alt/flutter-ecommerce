import 'dart:ffi';

class Product {
  final int? id;
  final String? title;
  final List<String>? images;
  final double? price;
  final String? description;

  Product({
    required this.id,
    required this.title,
    required this.images,
    required this.price,
    required this.description,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }
}
