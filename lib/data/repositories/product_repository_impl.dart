import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../domain/entities/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'package:http/http.dart' as http;

class ProductRepositoryImpl implements ProductRepository {
  final String apiUrl = 'https://api.escuelajs.co/api/v1/products';

  @override
  Future<Either<Failure, List<Product>>> fetchProducts(
      {int limit = 10, int offset = 0}) async {
    try {
      final Uri url = Uri.parse('$apiUrl?limit=$limit&offset=$offset');
      final response = await http.get(url);
      print("hi" + response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((json) => Product.fromJson(json)).toList();
        return Right(products);
      } else {
        return Left(Failure(
            message:
                'Failed to fetch products with status code: ${response.statusCode}'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
