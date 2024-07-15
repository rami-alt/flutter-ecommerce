import 'package:flutter_application_1/domain/entities/signup_user.dart';
import 'package:flutter_application_1/domain/usecases/signup_usecase.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final SignupUsecase signupUsecase;

  SignupController(this.signupUsecase);
  var signupUser = SignupUser(name: "", email: "", password: "").obs;
  Future<void> signup(String name, String email, String password) async {
    final result = await signupUsecase.signup(name, email, password);
    result.fold(
        (failure) => {Get.snackbar('Error', failure.message)},
        (signupUser) => {
              Get.snackbar('Success', 'Signup successful'),
              Get.offAllNamed('/home')
            });
  }
}
