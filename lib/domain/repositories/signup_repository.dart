import 'package:dartz/dartz.dart';

import '../entities/failure.dart';
import '../entities/signup_user.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupUser>> signup(SignupUser user);
}
