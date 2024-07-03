import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String email, String password) async {
    return await repository.login(email, password);
  }
}
