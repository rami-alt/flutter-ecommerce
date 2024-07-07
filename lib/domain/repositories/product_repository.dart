import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/failure.dart';
import 'package:flutter_application_1/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> fetchProducts(
      {int limit = 10, int offset = 0});
}
