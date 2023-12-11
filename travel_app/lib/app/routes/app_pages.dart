import 'package:get/get.dart';
import 'package:travel_app/app/modules/home/views/home_page.dart';
import 'package:travel_app/app/modules/home/views/navpages/main_page.dart';
import 'package:travel_app/app/modules/home/views/welcome_page.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const MainPage(),
      binding: HomeBinding(),
    ),
  ];
}