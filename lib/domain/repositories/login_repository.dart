import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/failure.dart';

import '../entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<bool> isLoggedIn();
  void logout();
}
