import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../core_functions/validate_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController loginController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey();
  bool showPassword = false; // Initialize the showPassword flag

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword; // Toggle the showPassword flag
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welcome\nBack!',
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                      width: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: FieldValidation
                          .validateEmail, // Use central validation for email
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          filled: true,
                          fillColor: Color.fromARGB(28, 168, 168, 169),
                          labelText: "Username or Email",
                          labelStyle: TextStyle(
                              color: Color(0xFF676767),
                              fontFamily: "Montserrat"),
                          prefixIcon: Icon(Icons.person_4_rounded,
                              color: Color.fromRGBO(98, 98, 98, 0.98)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(168, 168, 169, 1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: passwordController,
                      validator: FieldValidation
                          .validatePassword, // Use central validation for password
                      autocorrect: false,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          fillColor: const Color.fromARGB(28, 168, 168, 169),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: "Password",
                          filled: true,
                          labelStyle: const TextStyle(
                              color: Color(0xFF676767),
                              fontFamily: "Montserrat"),
                          prefixIcon: const Icon(Icons.lock,
                              color: Color.fromRGBO(98, 98, 98, 0.98)),
                          suffixIcon: IconButton(
                            onPressed: toggleShowPassword,
                            icon: const Icon(Icons.remove_red_eye_sharp),
                            color: const Color.fromRGBO(98, 98, 98, 0.98),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(168, 168, 169, 1)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                color: Color(0xFFCD3534),
                                fontFamily: "Montserrat",
                                fontSize: 12)),
                        onTap: () {
                          print('forget password hit');
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Obx(() {
                      if (loginController.isLoading.value) {
                        return CircularProgressIndicator(
                          color: Colors.black,
                          semanticsLabel: String.fromCharCode(20),
                        );
                      }
                      return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              loginController.login(emailController.text,
                                  passwordController.text);
                            } else {
                              print('credentials not valid');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(317, 55),
                            backgroundColor: const Color(0xFFF89939),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            maximumSize: const Size(317,
                                55), // Set button width to match the parent
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xFFFFFFFFF),
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ));
                    }),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Create An Account ',
                            style: TextStyle(
                                color: Color(0xFF575757),
                                fontFamily: "Montserrat",
                                fontSize: 14)),
                        GestureDetector(
                          onTap: () {
                            Get.offNamed('/signup');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFFCD3534),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFFCD3534),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
