import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/widgets/Custom_textfield.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/widgets/custom_button1.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/login_cubit/login_cubit.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/login_cubit/login_state.dart';
import 'package:waterbuddy/Features/Home/presentation/views/home_page.dart';

class LoginPage extends StatelessWidget {
  GlobalKey<FormState> login_key = GlobalKey();
  bool isLoading = false;
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Get.off(() => const HomePage());
          isLoading = false;
          showSnackBar(context, 'Logged in successfully');
        } else if (state is LoginFaliure) {
          showSnackBar(context, state.errMassage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontFamily: 'pacifico',
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Welcome back to the app',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'pacifico',
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Form(
                              key: login_key,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Email Adress',
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      CustomTextfield(
                                        validator: (data) {
                                          if (data!.isEmpty) {
                                            return 'this field is required';
                                          }
                                          return null;
                                        },
                                        onChanged: (data) {
                                          email = data;
                                        },
                                        label: 'E-mail',
                                        hintText: 'Enter your E-mail address',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      CustomTextfield(
                                        validator: (data) {
                                          if (data!.isEmpty) {
                                            return 'this field is required';
                                          }
                                          return null;
                                        },
                                        onChanged: (data) {
                                          password = data;
                                        },
                                        label: 'Password',
                                        hintText: 'Enter your password',
                                        obscureText: true,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: true,
                                        onChanged: (value) => false,
                                      ),
                                      const Text(
                                        'Keep me signed in',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'pacifico',
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CustomButton1(
                                    onTap: () async {
                                      if (login_key.currentState!.validate()) {
                                        BlocProvider.of<LoginCubit>(context)
                                            .login_user(
                                                email: email,
                                                password: password);
                                      }
                                    },
                                    text: 'Login',
                                  ),
                                  Row(
                                    children: [
                                      const Text('Dont have an account? ',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      InkWell(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed('signup'),
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 165, 201, 230)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Colors.black,
                ),
            ],
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String massege) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massege)));
  }
}
