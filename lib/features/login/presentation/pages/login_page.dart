import 'dart:ui';

import 'package:cflash/core/firebase_services/forgot_password.dart';
import 'package:cflash/core/firebase_services/get_current_username.dart';
import 'package:cflash/core/utility/pageRoutes.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/features/home/presentation/pages/home_page.dart';
import 'package:cflash/features/login/presentation/bloc/login_bloc.dart';
import 'package:cflash/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:cflash/features/sign_up/presentation/widget/divider_or.dart';
import 'package:cflash/features/sign_up/presentation/widget/signUpMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

/// TODO: Fix the Toast for Error not showing and Fix [Error] itself

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late bool _passwordVisible;
  bool isLoading = false;
  bool firstExec = false;

  @override
  void initState() {
    _passwordVisible = false;
    firstExec = false;
    super.initState();
  }

  void addLoginEvent() {
    BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(
      emailController.text,
      passwordController.text,
    ));
  }

  @override
  void dispose() {
    addLoginEvent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffA4CAE8),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              if (state is Initial) {
                return const SizedBox();
              } else if (state is Loading) {
              } else if (state is Loaded) {
                if (firstExec == false) {
                  if(getCurrentUser()!.uid.isNotEmpty){
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        isLoading = false;
                        firstExec = true;
                      });
                      Navigator.pushReplacement(
                          context,
                          FadePageRouteLR(
                            child: const HomePage(),
                            direction: AxisDirection.left,
                          ));
                    });
                  }
                }
              } else if (state is Error) {
                isLoading = false;

                Utility().toastMessage(state.message);
              }
              return const SizedBox();
            }),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const RiveAnimation.asset(
                  'asset/riveAssets/login.riv',
                  fit: BoxFit.fitHeight,
                )),
            Positioned.fill(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const SizedBox(),
            )),
            Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 120),
                child: Text(
                  'Login',
                  style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: const Color(0xffA4CAE8),
                  ),
                )),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3 + 150,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //Email Field
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
                          //Password field
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
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Password';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //Login button
                          CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                addLoginEvent();
                              }
                            },
                            isLoading: isLoading,
                            backGroundColor: const Color(0xff2E3F7A),
                            borderColor: const Color(0xff2E3F7A),
                            text: 'Login',
                            textColor: Colors.white,
                          ),
                          const Gap(20),
                          Row(

                            children: [
                               Gap(MediaQuery.of(context).size.width /1.68),
                              GestureDetector(
                                onTap:()=> Navigator.push(context, CustomPageRouteLR(child: const ForgotPasswordScreen(), direction: AxisDirection.up)),
                                  child: const Text(
                                "Forgot Password",
                                style:
                                    TextStyle(color: Color(0xff2E3F7A)),
                              )),
                              const SizedBox()
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SignUpMethods(),
                          const DividerOr(),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  ScaleFadePageRouteLR(
                                    child: const SignUpPage(),
                                    direction: AxisDirection.up,
                                  ));
                            },
                            backGroundColor: const Color(0xffA4CAE8),
                            borderColor: const Color(0xff2E3F7A),
                            text: 'Sign Up',
                            textColor: const Color(0xff2E3F7A),
                            isLoading: false,
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
