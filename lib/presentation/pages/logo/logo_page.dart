import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  Future<bool> checkLoginStatus() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return Get.find<LoginController>().isLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: Center(
              child: Image(
                alignment: Alignment.center,
                width: 274,
                height: 251,
                image: AssetImage('Images/PCNCLogo.png'),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: Center(
              child: Text('Error occurred'),
            ),
          );
        } else {
          if (snapshot.data == true) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Get.offNamed('/home');
            });
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Get.offNamed('/login');
            });
          }
          return Container(); // This widget will be replaced by the navigation
        }
      },
    );
  }
}
