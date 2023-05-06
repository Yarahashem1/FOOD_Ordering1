

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/register/cubit/states.dart';
import 'package:flutter_application_1/register/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  final _firestore = FirebaseFirestore.instance;

  void userRegister({
    required String name,
    required String email,
    required String password,
     //required String image
  
  }) {
    print('hello');

    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        email: email,
        name: name,

      );
      
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
  
     required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      //image:image,
      email: email,
      uId: uId,
      location:'Gaza strip',
      bio: 'write you bio ...',
      
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          //print("*******************************************************");
      emit(SocialCreateUserSuccessState());
      //print("liiiiiiiiiiiiiiiiiiiiiiii_________________________");
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }


  void getUserData() async {
    emit(SocialGetUserLoadingState());

    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
            await _firestore.collection('users').doc(signedInUser.uid).get();
        userModel = SocialUserModel.fromJson(userDoc.data());
        emit(SocialGetUserSuccessState());
      }
    } catch (error) {
      print('error');
      emit(SocialGetUserErrorState(error.toString()));
    }
  }
}