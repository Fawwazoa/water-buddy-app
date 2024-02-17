import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/widgets/Custom_textfield.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/widgets/custom_button1.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/signup_cubit/signup_cubit.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/signup_cubit/signup_state.dart';

class SignUp extends StatelessWidget {
  GlobalKey<FormState> signup_key = GlobalKey();
  String? password;
  String? email;
  String? username;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(context, 'homepage');
          isLoading = false;
          showSnackBar(context, "The account created successfully");
        } else if (state is RegisterFaliure) {
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
                      child: Column(children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create an account',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'pacifico',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Form(
                            key: signup_key,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Name',
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
                                      },
                                      onChanged: (data) {
                                        username = data;
                                      },
                                      label: 'Name',
                                      hintText: 'Enter your name',
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Email Address',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomButton1(
                                  onTap: () async {
                                    if (signup_key.currentState!.validate()) {
                                      BlocProvider.of<RegisterCubit>(context)
                                          .register_user(
                                              email: email!,
                                              password: password!);
                                    }
                                  },
                                  text: 'Sign Up',
                                ),
                                Row(
                                  children: [
                                    const Text('Have an account? ',
                                        style: TextStyle(color: Colors.black)),
                                    InkWell(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Text(
                                        'Login',
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
                            ))
                      ]),
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

  Future<void> signUpUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  Future<void> register_user() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
