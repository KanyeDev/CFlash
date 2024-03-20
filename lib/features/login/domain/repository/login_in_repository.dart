
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/features/login/domain/entity/login.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository{
  Future<Either<Failure, Login>> login(String email, String password);
}