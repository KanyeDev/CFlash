import 'package:cflash/core/error/exception.dart';
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/firebase_services/auth_services.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/login.dart';
import '../model/login_in_model.dart';

abstract class LoginDataSource {
  Future<Either<Failure, Login>> loginUser(String email, String password);
}
class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> data = [];

  @override
  Future<Either<Failure, Login>> loginUser(String email, String password) async {
    try {
      // Perform the login operation

      AuthService authService = AuthService();
      await authService.signInWithEmailAndPassword(email,  password);
      Utility().toastMessage('Login Successful');

      // Create a Login object with the provided email and password
      final login = Login(password: password, email:email);

      // Return the login object wrapped in a Right indicating success
      return Right(login);
    } catch (error) {
      // Handle errors
      final failure = ServerFailure(error.toString());
      Utility().toastMessage(error.toString());

      // Return a Failure object wrapped in a Left indicating failure
      return Left(failure);
    }
  }
}
