import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
 var cred;
      googlesign () async{
         final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();      
                                  // Obtain the auth details from the request
                                  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                                  // Create a new credential
                                  final credential = GoogleAuthProvider.credential(
                                    accessToken: googleAuth?.accessToken,
                                    idToken: googleAuth?.idToken,
                                  );

                                  // Once signed in, return the UserCredential
                                  return await FirebaseAuth.instance.signInWithCredential(credential).then((value){
                                   // print("****************************************************");
                                   cred=value.user!.email;
                                     emit(SocialLoginSuccessState(value.user!.uid));
                                  } )    .catchError((error)
                                  {
                                    emit(SocialLoginErrorState(error.toString()));
                                  });
                                    }

    void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          emit(SocialLoginSuccessState(value.user!.uid));
    })
        .catchError((error)
    {
      emit(SocialLoginErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialChangePasswordVisibilityState());
  }
}