import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/failure.dart';

import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> login(String email, String password) async {
    return await repository.login(email, password);
  }

  Future<bool> isLoggedIn() {
    return repository.isLoggedIn();
  }

  void logout() {
    repository.logout();
  }
}
