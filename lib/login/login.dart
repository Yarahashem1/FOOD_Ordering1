import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/adminHome.dart';

import 'package:flutter_application_1/components_login/components.dart';
import 'package:flutter_application_1/login/cubit/cubit.dart';
import 'package:flutter_application_1/login/cubit/states.dart';
import 'package:flutter_application_1/login/forget_password.dart';
import 'package:flutter_application_1/register/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../cashe.dart';
import '../app_screens/category.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: 'Error in email or password',
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            if (emailController.text == 'ahmaad6220@gmail.com' ||
                emailController.text == 'Ahmaad6220@gmail.com' ||
                SocialLoginCubit.get(context).cred == 'ahmaad6220@gmail.com') {
              CacheHelper.saveData(
                key: 'uIdAdmin',
                value: state.uId,
              ).then((value) {
                navigateTo(
                  context,
                  adminHome(),
                );
              });
            } else {
              CacheHelper.saveData(
                key: 'uIdCustomer',
                value: state.uId,
              ).then((value) {
                navigateTo(
                  context,
                  Category(),
                );
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFEDEDED),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        SizedBox(
                          height: 18.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          onSubmit: (value) {},
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextButton(
                          function: () {
                            navigateTo(
                              context,
                              forget(),
                            );
                          },
                          text: 'Forget password?',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),

                        /*  SizedBox(
                          height: 30.0,
                        ),
                             Container(

                              color: Color.fromARGB(179, 245, 240, 240),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   CircleAvatar(
                            radius: 20,

                          backgroundImage: NetworkImage('https://play-lh.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1'),

                          ),
                                   Center(
                                     child: defaultTextButton(
                                      function: () async{
                                        //await SocialLoginCubit.get(context).googlesign();
                                     final GoogleSignInAccount? googleAcount=  await googleSignIn.signIn();
                            },
                                      text: 'Continue with Google',
                            ),
                                   ),
                                 ],
                               ),
                             ),*/

                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
