import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password = '';
  String username = '';
  bool showPassword = false; // Initialize the showPassword flag
    final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController loginController = Get.find();

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword; // Toggle the showPassword flag
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 36,
                  ),
                ),
              ),
              const SizedBox(height: 40,width: 10,),
              TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: "Username or Email",
                    labelText: "Username or Email",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color.fromRGBO(98, 98, 98, 0.98),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(168, 168, 169, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 20),
              TextField(
                autocorrect: false,
                obscureText: !showPassword,
                onChanged: (value) {
                  setState(() {
                    password = value; // Update the password when input changes
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: toggleShowPassword,
                      icon: const Icon(Icons.remove_red_eye_sharp),
                      color: const Color.fromRGBO(98, 98, 98, 0.98),
                    ),
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color.fromRGBO(98, 98, 98, 0.98),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(168, 168, 169, 1)))),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.red)),
                  onTap: () {print('forget password hit');},
                ),
              ),
              const SizedBox(height: 15),
            Obx(() {
              if (loginController.isLoading.value) {
                return CircularProgressIndicator(color: Colors.black,semanticsLabel: String.fromCharCode(20),);
              }
              return ElevatedButton(
                  onPressed: () {
                  loginController.login(emailController.text, passwordController.text);
                  Get.offNamed('/home');
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Set button width to match the parent
                ),
              );
            }),
              Row(
                children: [const Text('Create An Account '),
                GestureDetector(onTap: () {
                  Get.offNamed('/signup');
                },child: const Text('signup!',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
