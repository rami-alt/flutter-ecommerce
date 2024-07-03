import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed('/login');
    });
    return const Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(
          child: Image(
            alignment: Alignment.center,
            width: 274,
            height: 251,
            image: AssetImage('Images/PCNCLogo.png'),
          ),
        ));
  }
}
