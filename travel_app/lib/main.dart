import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/app/modules/home/controllers/auth_controller.dart';
import 'package:travel_app/app/modules/home/controllers/notification_handler.dart';
import 'package:travel_app/app/modules/home/views/RegisterPage.dart';
import 'package:travel_app/app/modules/home/views/login_page.dart';
import 'package:travel_app/appwrite_client.dart';
import 'package:travel_app/cubit/app_cubit_logics.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/services/data_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AppwriteClientService());
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingHandler().initPushNotification();
  await FirebaseMessagingHandler().initLocalNotification();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubits(data: DataServices(),
        authController: Get.put(AuthController())
          )
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: '/register', // Set the initial route
      getPages: [
        GetPage(name: '/login', page: () => LoginView()), // Define the LoginPage route
        GetPage(name: '/register', page: () => RegisterPage()), // Define the RegisterPage route
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: AppCubitLogics(),
    );
  }
}
