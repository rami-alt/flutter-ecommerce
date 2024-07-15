import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/domain/entities/failure.dart';
import 'package:flutter_application_1/domain/entities/signup_user.dart';

import '../repositories/signup_repository.dart';

class SignupUsecase {
  final SignupRepository signupRepository;

  SignupUsecase(this.signupRepository);

  Future<Either<Failure, SignupUser>> signup(
      String name, String email, String password) async {
    final user = SignupUser(name: name, email: email, password: password);
    return await signupRepository.signup(user);
  }
}
