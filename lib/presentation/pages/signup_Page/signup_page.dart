import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/controllers/signup_controller.dart';
import 'package:get/get.dart';

import '../core_functions/validate_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SignupController signupController = Get.find();
  bool showPassword = false;
  bool showPasswordConfirm = false;
  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void toggleShowPasswordConfirm() {
    setState(() {
      showPasswordConfirm = !showPasswordConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Create an\naccount',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: const Color.fromARGB(28, 168, 168, 169),
                    labelStyle: const TextStyle(
                        color: Color(0xFF676767),
                        fontFamily: "Montserrat",
                        fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.person, color: Colors.black),
                  ),
                  validator: FieldValidation.validateUsername,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: const Color.fromARGB(28, 168, 168, 169),
                    labelStyle: const TextStyle(
                        color: Color(0xFF676767),
                        fontFamily: "Montserrat",
                        fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.email, color: Colors.black),
                  ),
                  validator: FieldValidation.validateEmail,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: const Color.fromARGB(28, 168, 168, 169),
                    labelStyle: const TextStyle(
                        color: Color(0xFF676767),
                        fontFamily: "Montserrat",
                        fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: toggleShowPassword,
                      icon: const Icon(Icons.remove_red_eye_sharp),
                      color: const Color.fromRGBO(98, 98, 98, 0.98),
                    ),
                  ),
                  validator: FieldValidation.validatePassword,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !showPasswordConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    filled: true,
                    fillColor: const Color.fromARGB(28, 168, 168, 169),
                    labelStyle: const TextStyle(
                        color: Color(0xFF676767),
                        fontFamily: "Montserrat",
                        fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: toggleShowPasswordConfirm,
                      icon: const Icon(Icons.remove_red_eye_sharp),
                      color: const Color.fromRGBO(98, 98, 98, 0.98),
                    ),
                  ),
                  validator: (value) => FieldValidation.validateConfirmPassword(
                      passwordController.text, value!),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 258,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 12, // Base font size
                          color: Color(0xFF676767), // Default text color
                          fontFamily:
                              'Montserrat', // Specify the font family if you have a custom one
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "By clicking the ",
                          ),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(color: Color(0xFFCD3534)),
                          ),
                          TextSpan(
                            text: " button, you agree to the public offer",
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF89939), // Button color
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 60, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        signupController.signup(usernameController.text,
                            emailController.text, passwordController.text);
                      } else {
                        print("credentials not valid");
                      }
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('I Already Have an Account ',
                        style: TextStyle(
                            color: Color(0xFF575757),
                            fontFamily: "Montserrat",
                            fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed('/login');
                      },
                      child: const Text(
                        'Login',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
