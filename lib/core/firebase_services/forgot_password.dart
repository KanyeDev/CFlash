import 'package:cflash/core/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utility/toast.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),

            const SizedBox(height: 40,),

            CustomButton(borderColor: const Color(0xff2E3F7A), isLoading: false, textColor: Colors.white,backGroundColor: const Color(0xff2E3F7A), text: "Forgot", onTap: (){

              setState(() {
                isLoading = true;
              });

              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){

                setState(() {
                  isLoading = false;
                });
                emailController.clear();
                Utility().toastMessage("Reset link sent to your mail for password recovery");
              }).onError((error, stackTrace) {
                Utility().toastMessage(error.toString());
                setState(() {
                  isLoading = false;
                });
              });

            })
          ],
        ),
      ),
    );
  }
}
