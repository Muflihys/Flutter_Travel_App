import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/modules/home/controllers/LoginController.dart';


class LoginView extends GetView<LoginController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
  final LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: Obx(
        () => Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      "img/login.png",
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter Email"),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      obscureText: controller.passToggle.value,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter Password"),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.togglePasswordVisibility();
                          },
                          child: controller.passToggle.value
                              ? Icon(CupertinoIcons.eye_slash_fill)
                              : Icon(CupertinoIcons.eye_fill),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        controller.onLoginButtonPressed(
                            emailController.text, passwordController.text);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF7165D6),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have any account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/register');
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7165D6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
