import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import '../../domain/entities/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final String categoriesUrl = 'https://api.escuelajs.co/api/v1/categories';

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(categoriesUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final categories = data.map((json) => Category.fromJson(json)).toList();
        return Right(categories);
      } else {
        return Left(Failure(message: 'Failed to fetch categories'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}