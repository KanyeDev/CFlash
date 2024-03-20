import 'dart:ui';

import 'package:cflash/features/login/presentation/pages/login_page.dart';
import 'package:cflash/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rive/rive.dart';
import '../../../../core/utility/pageRoutes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widget/divider_or.dart';
import '../widget/signUpMethods.dart';
import '/core/utility/toast.dart';



/// TODO: Correct the forever rotating circular indicator

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _passwordVisible;
  bool isLoading = false;
  bool firstExec = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffA4CAE8),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                if (state is Initial) {

                  return const SizedBox();
                } else if (state is Loading) {

                } else if (state is Loaded) {

                  if(firstExec == false){
                    Utility().toastMessage(
                        'Account Created Successfully');

                    Future.delayed(const Duration(milliseconds: 2500), (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                      setState(() {
                        isLoading = false;
                        firstExec = true;
                      });
                    });

                  }
                  ///Todo: navigate to the home page
                } else if (state is Error) {
                  Utility().toastMessage(state.message);
                  Future.delayed(const Duration(milliseconds: 2500), (){
                    setState(() {
                      isLoading = false;
                    });
                  });
                }
                return const SizedBox();
              },
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                    const RiveAnimation.asset('asset/riveAssets/signup.riv', fit: BoxFit.fitHeight,)),
            Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const SizedBox(),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 120),
              child: Text( 'Sign Up', style:  GoogleFonts.pacifico(
                  fontWeight: FontWeight.bold,
                  fontSize: 30, color: const Color(0xff2E3F7A),
                ),)
              ),
            SafeArea(
              child: Column(
                ///Todo: create the signup page, asap
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 30, right: 30),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              userNameController: userNameController,
                              hintText: 'Username',
                              keyboardType: TextInputType.name,
                              icon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              returnText: 'Enter UserName',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              userNameController: emailController,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              icon: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              returnText: 'Enter Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: !_passwordVisible,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                fillColor: Colors.black,
                                hintText: 'Password',
                                hintStyle:
                                    const TextStyle(color: Colors.blueGrey),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    )),
                                prefixIcon: const Icon(Icons.lock, color: Colors.black,),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                }
                                return null;
                              },
                              // onFieldSubmitted: (_) {
                              //   addSignUpEvent();
                              // },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //sign up btn location
                            CustomButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  addSignUpEvent();
                                }
                              },
                              isLoading: isLoading,
                              backGroundColor: const Color(0xff2E3F7A),
                              borderColor: const Color(0xff2E3F7A),
                              text: 'Sign Up',
                              textColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //Contains google, facebook and microsoft signup
                            const SignUpMethods(),
                            const DividerOr(),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              onTap: () {
                                Navigator.push(context, ScaleFadePageRouteLR(child: const LoginPage(), direction: AxisDirection.up,));
                              },
                              backGroundColor: const Color(0xffA4CAE8),
                              borderColor: const Color(0xff2E3F7A),
                              text: 'Login',
                              textColor: const Color(0xff2E3F7A),
                              isLoading: false,
                            ),

                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addSignUpEvent() {
    BlocProvider.of<SignUpBloc>(context).add(SignUpNewUserEvent(
        emailController.text,
        passwordController.text,
        userNameController.text));
  }
}


