import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/login.dart';

import '../components_login/components.dart';

class forget extends StatelessWidget {
  
   var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_forward_ios),
      onPressed: (){
          navigateAndFinish(
                context,
                SocialLoginScreen(),
              );
      },),
      title: Text("Forget Password"),
      ),
      body:Center(
        child: 
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            SizedBox(height: 200,),
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
                              height: 30.0,
                            ),
                             
                            defaultButton(
                                function: () async{
                                  var forgetpass=   emailController.text.trim();
                                  try{
                                       FirebaseAuth.instance.sendPasswordResetEmail(email: forgetpass)
                                       .then((value) => {
                                        showToast(
                                       text: 'Email sent',
                                      state: ToastStates.SUCCESS,
                                               )
                                         
                                       });
                                  }on FirebaseAuthException catch(e){
                                    print('error');
                                  }
                                   
                                },
                                text: 'Forget password',
                                isUpperCase: false,
                              ),
                           
          ]),
        ),
      ) ,
    );
  }
}