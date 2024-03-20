import 'dart:ui';

import 'package:cflash/core/utility/pageRoutes.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/features/login/presentation/pages/login_page.dart';
import 'package:cflash/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';

import 'core/firebase_services/auth_services.dart';
import 'core/widgets/custom_button.dart';
import 'features/home/presentation/pages/home_page.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xffA4CAE8),
        body: FutureBuilder<User?>(
            future: AuthService().autoLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loading indicator while checking auto-login
                return  Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(40), child: Image.asset("asset/images/Cflash.jpg")),
                      const Gap(30),
                      const CircularProgressIndicator(color: Color(0xff2E3F7A),),
                      const Gap(20),
                      const Text("Please Wait!")
                    ],
                  ),
                );
              } else {
                if (snapshot.hasData) {
                  // User is already logged in, navigate to home page
                  Utility().toastMessage("Login Successful");

                  return const HomePage();
                } else {
                  // User is not logged in, navigate to login page
                  return Stack(
                    children: [
                      Positioned(
                          bottom: 0,
                          child: Image.asset(
                            "asset/images/curvebtm.png",
                            fit: BoxFit.contain,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("asset/images/curvetop.png"),
                          SizedBox(width: MediaQuery.of(context).size.width/1.2, child: Image.asset("asset/images/CFlogo.png",)),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //sign up btn
                              CustomButton(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      FadePageRouteLR(
                                        child: const SignUpPage(),
                                        direction: AxisDirection.right,
                                      ));
                                },
                                width: 150,
                                backGroundColor: const Color(0xffA4CAE8),
                                borderColor: const Color(0xff2E3F7A),
                                text: 'Sign Up',
                                textColor: const Color(0xff2E3F7A),
                                isLoading: false,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              //Login Btn
                              CustomButton(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      FadePageRouteLR(
                                        child: const LoginPage(),
                                        direction: AxisDirection.left,
                                      ));
                                },
                                width: 150,
                                backGroundColor: const Color(0xff2E3F7A),
                                borderColor: const Color(0xff2E3F7A),
                                text: 'Login',
                                textColor: Colors.white,
                                isLoading: false,
                              ),

                              const SizedBox(
                                height: 120,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                }
              }
            }));
  }
}
