import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/app/modules/home/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {

  final ProfileController controller = Get.put(ProfileController());
  // final ProfileController controller = Get.find<ProfileController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ProfileView({super.key}) {
    controller.name.listen((value) => nameController.text = value);
    controller.username.listen((value) => usernameController.text = value);
    controller.email.listen((value) => emailController.text = value);
    controller.password.listen((value) => passwordController.text = value);
  }

  void _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Galeri'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      controller.imagePath.value = File(pickedFile.path);
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Kamera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile != null) {
                      controller.imagePath.value = File(pickedFile.path);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Profile"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => GestureDetector(
                onTap: () => _pickImage(context),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _getImageProvider(controller),
                  child: _getImageProvider(controller) == null
                      ? Icon(Icons.add_a_photo, size: 100)
                      : null,
                ),
              ),
            ),
            SizedBox(height: 16),
            buildTextField(nameController, controller.name, 'Nama'),
            SizedBox(height: 16),
            buildTextField(usernameController, controller.username, 'Username'),
            SizedBox(height: 16),
            buildTextField(emailController, controller.email, 'Email'),
            SizedBox(height: 16),
            buildTextField(passwordController, controller.password, 'Password'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.addProfile(
                    nameController.text,
                    usernameController.text,
                    emailController.text,
                    passwordController.text);
              },
              child: Text("Tambah"),
            ),
            SizedBox(height: 16),
            // Tombol Hapus Akun
            ElevatedButton(
              onPressed: () {
                // Logika untuk menghapus akun
                controller.deleteAccount();
              },
              child: Text("Hapus Akun"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Warna merah untuk aksi hapus
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object>? _getImageProvider(ProfileController controller) {
    if (controller.imagePath.value != null) {
      return FileImage(controller.imagePath.value!);
    } else if (controller.avatarLoad.value != null) {
      return NetworkImage(controller.avatarLoad.value!);
    }
    return null;
  }

  Widget buildTextField(
      TextEditingController textController, RxString value, String label) {
    return TextField(
      controller: textController,
      onChanged: (text) {
        value.value = text;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}