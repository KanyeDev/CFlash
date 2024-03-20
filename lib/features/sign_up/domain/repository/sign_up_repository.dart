import 'package:cflash/core/error/failure.dart';
import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUp>> createUser(String uid, String userName, String email);
  Future<Either<Failure, SignUp>> registerUser(String email, String password, String userName);
}