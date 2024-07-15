import 'package:get/get.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  var isLoading = false.obs;
  var user = User(email: "", accessToken: "", refreshToken: "").obs;

  LoginController(this.loginUseCase);

  Future<void> login(String email, String password) async {
    final result = await loginUseCase.login(email, password);
    result.fold(
        (failure) => {Get.snackbar('Error', failure.message)},
        (user) => {
              this.user.value = user,
              Get.snackbar('Success', 'Login successful'),
              Get.offAllNamed('/home')
            });
  }

  Future<bool> isLoggedIn() async {
    return await loginUseCase.isLoggedIn();
  }

  void logout() {
    loginUseCase.logout();
  }
}
