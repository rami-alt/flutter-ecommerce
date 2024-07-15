import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../controllers/login_controller.dart';

class LogoutDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const LogoutDrawer(this._scaffoldKey, {super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: TextButton(
          child: const Text(
            "Logout",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.find<LoginController>().logout();
                          Get.offNamed('/login');
                        },
                        child: const Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _scaffoldKey.currentState!.closeDrawer();
                        },
                        child: const Text("No"),
                      ),
                    ],
                  ))),
    );
  }
}
