import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/app/modules/home/views/login_page.dart';
import 'package:travel_app/app/modules/home/views/welcome_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoggedIn();
  }
  void goHome() {
    Get.to(WelcomePage());
  }


  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.green);
      Get.off(LoginView());
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.green);
      isLoggedIn.value = true;
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _auth.signOut();
      Get.snackbar('Success', 'Logout successful',
          backgroundColor: Colors.green);
      isLoggedIn.value = false;
      Get.off(LoginView());
    } catch (error) {
      Get.snackbar('Error', 'Logout failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  
  Future<void> checkLoggedIn() async {
    await Future.delayed(Duration(seconds: 1)); 
    isLoggedIn.value = _auth.currentUser != null;
  }

  bool isUserLoggedIn() {
    return isLoggedIn.value;
  }

  

  Future<void> _clearCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('token');
  }


}
