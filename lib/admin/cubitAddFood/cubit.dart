import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/admin/cubitAddFood/modelAdmin.dart';
import 'package:flutter_application_1/admin/cubitAddFood/statesAddFood.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodCubit extends Cubit<AddFoodStates> {
  AddFoodCubit() : super(AddFoodInitialState());
  
  static AddFoodCubit get(context) => BlocProvider.of(context);



void adminAdd({
    required String category,
    required String description,
    required String name,
    required String price,
    required String uid,
    required String url,
  }) {
    emit(AddFoodLoadingState());
    FoodCreate(
      category: category,
      description: description,
      name: name,
      price: price,
      url: url,
      uid: uid,
    );
  }

  void FoodCreate({
    required String category,
    required String description,
    required String name,
    required String price,
    required String uid,
    required String url,
  }) {
    AddFoodModel model = AddFoodModel(
      price: price,
      uid: uid,
      category: category,
      description: description,
      name: name,
      url: url,
    );
    FirebaseFirestore.instance
        .collection(category)
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(CreateFoodSuccessState());
    }).catchError((error) {
      emit(CreateFoodErrorState(error));
    });
  }
   String? newValue;
  String category(String? val){
    newValue =val!;
     emit(categorySuccessState());
      return newValue!;
  }

 File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AddFoodProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AddFoodProfileImagePickedErrorState());
    }
  }
  var imageUrl = '';
  void uploadProfileImage() {
    emit(AddFoodUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        emit(AddFoodUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(AddFoodUploadProfileImageErrorState());
      
      });
    }).catchError((error) {
      emit(AddFoodUploadProfileImageErrorState());
    });
  }


  String generateRandomString() {
  final random = Random();
  const letters = 'abcdefghijklmnopqrstuvwxyz';
  final codeUnits = List.generate(3, (index) {
    final index = random.nextInt(letters.length);
    return letters.codeUnitAt(index);
  });
  return String.fromCharCodes(codeUnits);
}
}