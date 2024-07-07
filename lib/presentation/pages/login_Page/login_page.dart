
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password = '';
  String username = '';
  bool showPassword = false; // Initialize the showPassword flag
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController loginController = Get.find();
    GlobalKey<FormState> formKey = GlobalKey();

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword; // Toggle the showPassword flag
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          
          padding: const EdgeInsets.all(16),
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
              const SizedBox(
                height: 40,
                width: 10,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "username can't be empty";
                  }
                  if(value.length < 6|| value.length > 20)
                  {
                    return "username must be between 6 and 20 characters";
                  }
                  return null;
                },
                decoration: const InputDecoration(
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
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  
                  if (value!.isEmpty) {
                    return "password can't be empty";
                  }
                  if(value.length < 6|| value.length > 20)
                  {
                    return "password must be between 6 and 20 characters";
                  }

                  return null;
                },
                autocorrect: false,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))), 
                    suffixIcon: IconButton(
                      onPressed: toggleShowPassword,
                      icon: const Icon(Icons.remove_red_eye_sharp),
                      color: const Color.fromRGBO(98, 98, 98, 0.98),
                    ),
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
                  onTap: () {
                    print('forget password hit');
                  },
                ),
              ),
              const SizedBox(height: 15),
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
                      loginController.login(emailController.text, passwordController.text);
                      print("${passwordController.text}  ${emailController.text}");
                    }else{
                      print('error');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity,
                        50), // Set button width to match the parent
                  ),
                  child: const Text('Login'),
                );
              }),
              Row(
                children: [
                  const Text('Create An Account '),
                  GestureDetector(
                    onTap: () {
                      Get.offNamed('/signup');
                    },
                    child: const Text(
                      'signup!',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
