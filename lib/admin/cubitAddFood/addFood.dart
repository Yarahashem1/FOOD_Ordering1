import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/adminHome.dart';
import 'package:flutter_application_1/admin/cubitAddFood/cubit.dart';
import 'package:flutter_application_1/admin/cubitAddFood/statesAddFood.dart';
import 'package:flutter_application_1/components_login/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddFood extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var priceController = TextEditingController();
   var descriptionController = TextEditingController();
   var imageController = TextEditingController();
    String? dropdownValue = 'Meals';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddFoodCubit(),
      child: BlocConsumer<AddFoodCubit, AddFoodStates>(
        listener: (context, state) {
          if(state is AddFoodProfileImagePickedSuccessState)
            AddFoodCubit.get(context).uploadProfileImage();
          if (state is CreateFoodErrorState) {
            showToast(
              text: 'Error in adding food',
              state: ToastStates.ERROR,
            );
          } if(state is CreateFoodSuccessState){
             showToast(
              text: 'Successfully Added',
              state: ToastStates.SUCCESS,
            );
             Navigator.pop(context);
          }
             
        },
        builder: (context, state) {
           var profileImage = AddFoodCubit.get(context).profileImage;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),
            onPressed: (){
              navigateAndFinish(
                      context,
                      adminHome(),
                    );},),
                    title: Text("Add Food"),
                    backgroundColor: Colors.green,),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        defaultFormField2(
                          controller: nameController,
                          isClickable: true,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter Food name';
                            }
                          },
                          label: 'Food Name',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField2(
                          controller: priceController,
                          isClickable: true,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter Food price';
                            }
                          },
                          label: 'Food Price',
                        ),
                          SizedBox(
                          height: 15.0,
                        ),
                        
                        defaultFormField2(
                          controller: descriptionController,
                          isClickable: true,
                          type: TextInputType.multiline,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter Food Description';
                            }
                          },
                          label: 'Food Description',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                              Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                             Container(
                                    decoration: BoxDecoration(shape: BoxShape.rectangle,                                  
                                    color: Colors.white70),
                                  ),
                            if (profileImage == null)
                               defaultFormField2(
                          controller: imageController,
                          isClickable:false,
                          type: TextInputType.multiline,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter Image';
                            }
                          },
                          label: 'Image',
                        ),
                             SizedBox(height: 20,),
                                 

                            if (profileImage != null)
                              Container(
                                  child: Image(image:  FileImage(profileImage),
                                    height:150 ,
                                    width:double.infinity,
                                    fit: BoxFit.cover,
                                    ),
                                    decoration: BoxDecoration(shape: BoxShape.rectangle,

                                    color: Colors.white70),
                                  ),
                            SizedBox(height: 10,),
                            if(state is AddFoodUserUpdateLoadingState)
                              Center(child: LinearProgressIndicator(),),
                            SizedBox(height: 15,),

                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.camera_enhance,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                AddFoodCubit.get(context)
                                    .getProfileImage();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                              
                      Container(
                       // width: double.infinity,
                         decoration: BoxDecoration(shape: BoxShape.rectangle,
                                   
                                    color: Colors.white70),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          items: <String>['Meals', 'Snacks', 'Drinks','Shandwish']
                              .map<DropdownMenuItem<String>>((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (item){
                              dropdownValue=
                               AddFoodCubit.get(context)
                                  .category(item);
                          }
                        
                        ),
                      ),
   

                              SizedBox(
                          height: 15.0,
                        ),
                         defaultButton(
                            function: () async{
                              String uid = AddFoodCubit.get(context).generateRandomString();
                              var cubit = AddFoodCubit.get(context);
                              if (formKey.currentState!.validate()) {
                                if(dropdownValue == 'Meals')
                                  cubit.adminAdd(category: 'Meals', description: descriptionController.text, name: nameController.text, price: priceController.text, uid: uid, url: cubit.imageUrl);
                                if(dropdownValue == 'Snacks')
                                  cubit.adminAdd(category: 'Snacks', description: descriptionController.text, name: nameController.text, price: priceController.text, uid: uid, url: cubit.imageUrl);
                                if(dropdownValue == 'Drinks')
                                  cubit.adminAdd(category: 'Drinks', description: descriptionController.text, name: nameController.text, price: priceController.text, uid: uid, url: cubit.imageUrl);
                                if(dropdownValue == 'Shandwish')
                                  cubit.adminAdd(category: 'Shandwish', description: descriptionController.text, name: nameController.text, price: priceController.text, uid: uid, url: cubit.imageUrl);
                              }
                            },
                            text: 'Add Food',

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