import 'package:get/get.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  var isLoading = false.obs;
  var user = Rx<User?>(null);
  var errorMessage = ''.obs;

  LoginController(this.loginUseCase);

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      user.value = await loginUseCase.execute(email, password);
      Get.offNamed('/signup'); // Navigate to the home screen on success
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
