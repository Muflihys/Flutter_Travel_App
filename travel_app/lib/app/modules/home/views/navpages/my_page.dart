import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:travel_app/app/modules/home/controllers/auth_controller.dart';
import 'package:travel_app/app/modules/home/profile/views/profile_view.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // title: Text(
        //   'Akun',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 18,
        //     fontFamily: 'Plus Jakarta Sans',
        //   ),
        // ),
        centerTitle: true,
        elevation: 0,
      ),

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        width: double.infinity,
        height: 415,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
          color: Colors.white,
          boxShadow:[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 4)
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 215,
              child: GestureDetector(
                onTap: () {
                  // Navigate to the profile page when the photo is tapped
                  Get.to(ProfileView());
                },
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Image.asset(
                    'img/maphoto.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                )
              )
            ),
            Positioned(
              bottom: 150,
              child: Text(
                'Anargya Aryadaffa',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              )
            ),
            Positioned(
              bottom: 129,
              child: Text(
                'Having an adventure all the time is my dream',
                style: TextStyle(
                  color: Color(0xFF5D5D5D),
                  fontSize: 12,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              )
            ),
            Positioned(
              bottom: 30,
              child: GestureDetector(
                onTap: () {
                  AuthController authController = AuthController();
                  authController.logout();
                },
                child: const Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFFA0A0A0),
                  fontSize: 12,
                  fontFamily: 'Plus Jakarta Sans',
                ),
              )
              ),
            ),
          ],
        ),
      ),
    );
  }
}