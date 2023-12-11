import 'package:bloc/bloc.dart';
import 'package:travel_app/app/modules/home/controllers/auth_controller.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/model/data_model.dart';
import 'package:travel_app/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({
    required this.data,
    required AuthController authController,
  }) : super(InitialState()) {
    _authController = authController;
    emit(WelcomeState());
  }

  late AuthController _authController;

  final DataServices data;
  late final List<DataModel> places;

  void getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
    } catch (e) {
      // Handle error
    }
  }

  void getHomePage() async{
    try {
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
    } catch (e) {
      print("Error loading data: $e");
      emit(ErrorState("An error occurred while loading data: $e"));
    }
  }

  detailPage(DataModel data) {
    emit(DetailState(data));
  }

  void goHome() async {
  try {
      emit(LoadingState());
      emit(HomePage());// tambahkan ini untuk menavigasi ke halaman home setelah mendapatkan data
      emit(LoadedState(places));
  } catch (e) {
    // Handle error
  }
}

  void goLogin() {
    _authController.loginUser("your_email@example.com", "your_password");
  }

}



