import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:travel_app/app/data/UserService.dart';
import 'package:travel_app/app/modules/home/views/welcome_page.dart';

class LoginController extends GetxController {
  var passToggle = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserService _userService = UserService();

  void togglePasswordVisibility() {
    passToggle.value = !passToggle.value;
  }
  

  void onLoginButtonPressed(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var userData =
          await _userService.getUserByEmailAndPassword(email, password);
      
      Get.snackbar(
          'Success', // Judul
          'Login Successfull', // Pesan
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 5),
          icon: Icon(Icons.error_outline, color: Colors.white),
        );


      if (userData != null) {
        // Simpan informasi ke SharedPreferences
        await _saveLoginInfo(
            email, password, userData, userCredential.user!.uid);

        // Arahkan ke halaman Home jika berhasil
        Get.off(WelcomePage());
      } else {
        // Tampilkan pesan error jika tidak ada data user
        showCustomSnackbar('FAILED', 'Tidak ada data pengguna yang ditemukan.');
      }
    } catch (e) {
      String errorMessage =
          'An unexpected error occurred. Please check your account.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password provided.';
            break;
          default:
            break;
        }
      }

      // Memanggil fungsi custom Snackbar
      showCustomSnackbar('Login Error', errorMessage);
    }
  }

  void onRegisterButtonPressed(String name, String username, String email,
      String password, String confirmPassword) async {
    if (password != confirmPassword) {
      showCustomSnackbar('Registration Error', 'Passwords do not match.');
      return;
    }

    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      showCustomSnackbar('Registration Error', 'Invalid email format.');
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _userService.createUser(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      Get.snackbar(
        'Success', // Judul
        'Registration successful, Please login', // Pesan
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        snackStyle: SnackStyle.FLOATING,
        duration: Duration(seconds: 5),
        icon: Icon(Icons.error_outline, color: Colors.white),
      );
    } catch (e) {
      String errorMessage = 'Registration failed: ${e.toString()}';
      if (e is FirebaseAuthException && e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      }
      showCustomSnackbar('Registration Error', errorMessage);
    }
  }

  Future<void> _saveLoginInfo(String email, String password,
      Map<String, dynamic> userData, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    // Hanya simpan password jika benar-benar diperlukan (tidak disarankan)
    await prefs.setString('password', password);
    await prefs.setString('token', token);

    // Simpan data user dari Appwrite
    await prefs.setString('user_data', jsonEncode(userData));
  }

  void showCustomSnackbar(String title, String message) {
    Get.snackbar(
      title, // Judul
      message, // Pesan
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      snackStyle: SnackStyle.FLOATING,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.error_outline, color: Colors.white),
    );
  }
}
