import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/app/modules/home/views/home_page.dart';
import 'package:travel_app/app/modules/home/views/navpages/main_page.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/misc/Colors.dart';
import 'package:travel_app/widgets/app_text.dart';


class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;

  ResponsiveButton({Key? key, this.width = 120, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Button tapped!"); // Add this line to see if the button is tapped
        BlocProvider.of<AppCubits>(context).getData();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      },
      child: Container(
        width: isResponsive == true ? double.infinity : width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Row(
          mainAxisAlignment: isResponsive == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            isResponsive == true
                ? Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: AppText(
                      text: "Book Trip Now",
                      color: Colors.white,
                    ),
                  )
                : Container(),
            Image.asset("img/button-one.png"),
          ],
        ),
      ),
    );
  }
}
