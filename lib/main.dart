import 'package:cflash/features/login/presentation/bloc/login_bloc.dart';
 import 'package:cflash/features/sign_up/presentation/bloc/sign_up_bloc.dart';
 import 'package:cflash/features/subject/presentation/bloc/subject_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'onboarding.dart';



/// TODO: Remove unnecessary functions from the sigup and login data model

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(

      MultiBlocProvider(providers: [
  BlocProvider<SignUpBloc>(
  create: (BuildContext context) => sl<SignUpBloc>(),),

    BlocProvider<LoginBloc>(create: (BuildContext context) => sl<LoginBloc>(),),

    BlocProvider<SubjectBloc>(create: (BuildContext context) => sl<SubjectBloc>()),

  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnBoarding(),
    );
  }
}
