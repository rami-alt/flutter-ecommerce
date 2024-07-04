import 'package:dartz/dartz.dart';

import '../entities/category.dart';
import '../entities/failure.dart';

abstract class CategoryRepository{
  Future<Either<Failure, List<Category>>> getCategories();
}
