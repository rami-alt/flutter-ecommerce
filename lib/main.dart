import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/repositories/login_repository.dart';
import 'package:flutter_application_1/presentation/pages/home_page/home_page_main.dart';
import 'package:flutter_application_1/presentation/pages/login_Page/login_page.dart';
import 'package:flutter_application_1/presentation/pages/logo/logo_page.dart';
import 'package:flutter_application_1/presentation/pages/signup_Page/signup_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'data/repositories/login_repository_impl.dart';
import 'data/repositories/signup_repository_impl.dart';
import 'domain/repositories/signup_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/signup_usecase.dart';
import 'presentation/controllers/login_controller.dart';
import 'presentation/controllers/signup_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injection
  Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl());
  Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<LoginRepository>()));
  Get.lazyPut<LoginController>(() => LoginController(Get.find<LoginUseCase>()));
  Get.lazyPut<SignupUsecase>(() => SignupUsecase(Get.find<SignupRepository>()));
  Get.lazyPut<SignupRepository>(() => SignupRepositoryImpl());
  Get.lazyPut<SignupController>(
      () => SignupController(Get.find<SignupUsecase>()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LogoPage(),
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => const SignupPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/logo', page: () => const LogoPage()),
      ],
    );
  }
}
