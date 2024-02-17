import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:waterbuddy/Core/Utils/assets.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/login_page.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/signup_page.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/widgets/custom_button1.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/widgets/custom_button2.dart';

class WelPageBody extends StatelessWidget {
  const WelPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(
                height: 40,
              ),
              const Image(
                image: AssetImage(AssetsPath.logo),
                height: 350,
              ),
              CustomButton1(
                text: "Login",
                onTap: () {
                  Get.to(() => LoginPage());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  " ------------ Dont you have an acccount? -------------",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton2(
                text: 'Sign up',
                onTap: () {
                  Get.to(() => SignUp());
                },
              )
            ],
          )),
    );
  }
}
