import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/modules/home/views/detail_page.dart';
import 'package:travel_app/app/modules/home/views/login_page.dart';
import 'package:travel_app/app/modules/home/views/navpages/main_page.dart';
import 'package:travel_app/app/modules/home/views/welcome_page.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  late bool _showLoginPage;

  @override
  void initState() {
    super.initState();
    _showLoginPage = true; 
  }

  void onLoginSuccess(BuildContext context) {
    setState(() {
      _showLoginPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (_showLoginPage) {
            return LoginView();
          }

          if (state is DetailState) {
            return DetailPage();
          }

          if (state is WelcomeState) {
            return WelcomePage();
          }

          if (state is LoadedState) {
            return MainPage();
          }

          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

