import 'package:flutter_application_1/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required id,
    required title,
    required images,
    required price,
    required description,
  }) : super(
          id: id,
          title: title,
          images: images,
          price: price,
          description: description,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      images: json['images'],
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'images': images,
      'price': price,
      'description': description,
    };
  }
}
