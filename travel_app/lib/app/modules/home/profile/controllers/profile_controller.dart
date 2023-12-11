import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/app/data/UserService.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var email = ''.obs;
  var imagePath = Rx<File?>(null);
  var avatarLoad = Rx<String?>(null);
  var oldPass = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final UserService _userService;
  String documentId = '';

  ProfileController() {
    _userService = UserService();
    _loadUserData();
  }

  void _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString('user_data');

    if (userDataJson != null) {
      Map<String, dynamic> userData = jsonDecode(userDataJson);
      documentId = userData['\$id'];
      oldPass.value = userData['password']; // Use .value for RxString

      // Memanggil getUser untuk mengambil data pengguna
      var userDetail = await _userService.getUser(documentId);
      name.value = userDetail['name']; // Use .value
      username.value = userDetail['username']; // Use .value
      email.value = userDetail['email']; // Use .value
      password.value = userDetail['password']; // Use .value

      if (userDetail['images'] != null) {
        String imageUrl =
            await _userService.getPublicImageUrl(userDetail['images']);
        avatarLoad.value = imageUrl; // Use .value
      }
    }
  }

  void addProfile(String newFullname, String newUsername, String newEmail,
      String newPassword) async {
    name.value = newFullname;
    username.value = newUsername;
    email.value = newEmail;
    password.value = newPassword;

    Map<String, dynamic> data = {
      'name': newFullname,
      'username': newUsername,
      'email': newEmail,
      'password':
          newPassword, // Pertimbangkan keamanan saat mengupdate password
    };

    if (imagePath.value != null) {
      String fileId = await _userService.uploadImageToStorage(imagePath.value!);
      data['images'] = fileId;
    }

    try {
      await _userService.updateUser(documentId: documentId, data: data);

      User? user = _auth.currentUser;
      if (user != null) {
        if (user.email != newEmail) {
          await user.updateEmail(newEmail);
        }
        if (oldPass != newPassword) {
          await user.updatePassword(newPassword);
        }
      }

      showCustomSnackbar(
          'Success', "Profile berhasil diupdate dalam firebase dan appwrite");
      print("Profile Updated Successfully");
    } catch (e) {
      print("Error updating profile: ${e.toString()}");
    }
  }

  void updateAvatar(File newAvatar) async {
    imagePath.value = newAvatar;

    try {
      String fileId = await _userService.uploadImageToStorage(newAvatar);
      Map<String, dynamic> data = {'images': fileId};

      await _userService.updateUser(documentId: documentId, data: data);
      print("Avatar updated successfully");
    } catch (ex) {
      print("Failed to update avatar: ${ex.toString()}");
    }
  }

  void showCustomSnackbar(String title, String message) {
    Get.snackbar(
      title, // Judul
      message, // Pesan
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      snackStyle: SnackStyle.FLOATING,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.error_outline, color: Colors.white),
    );
  }

  void deleteAccount() async {
    try {
      var userDetail = await _userService.getUser(documentId);
      var delEmail = userDetail['email'];
      // Menghapus akun pengguna dari Firebase
      User? currentUser = _auth.currentUser;
      if (currentUser?.email == delEmail) {
        await currentUser?.delete();
        print("Akun Firebase berhasil dihapus");

        // Sign out dari Firebase
        await _auth.signOut();

        // Lanjutkan dengan menghapus data dari Appwrite
        await _userService.deleteUser(documentId);
        print("Data pengguna dihapus dari Appwrite");

        // Membersihkan SharedPreferences
        await _clearSharedPreferences();
        print("SharedPreferences dibersihkan");

        // Navigasi ke layar login setelah penghapusan akun
        Get.offAllNamed('/login');
      } else {
        print("Email pengguna saat ini tidak sesuai");
      }
    } catch (e) {
      print("Gagal menghapus akun: $e");
    }
  }

  Future<void> _clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void showConfirmationDialog(String title, String content) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void showErrorDialog(String title, String content) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
