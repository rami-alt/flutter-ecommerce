
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/repositories/login_repository.dart';
import 'package:flutter_application_1/presentation/pages/home_page/home_page.dart';
import 'package:flutter_application_1/presentation/pages/login_Page/login_page.dart';
import 'package:flutter_application_1/presentation/pages/logo/logo_page.dart';
import 'package:flutter_application_1/presentation/pages/signup_Page/signup_page.dart';
import 'package:get/get.dart';

import 'data/repositories/login_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/controllers/login_controller.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injection
  
  Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl());
  Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<LoginRepository>()));
  Get.lazyPut<LoginController>(() => LoginController(Get.find<LoginUseCase>()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LogoPage(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/login', page: ()=> const LoginPage()),
        GetPage(name: '/signup', page: ()=>const SignupPage()),
        GetPage(name: '/home', page: ()=>const HomePage())

      ],
    );
  }
}

