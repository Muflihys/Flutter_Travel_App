import 'package:get/get.dart';
import 'package:travel_app/app/modules/home/controllers/LoginController.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
