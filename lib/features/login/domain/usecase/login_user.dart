
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/usecase/usecase.dart';
import 'package:cflash/features/login/domain/entity/login.dart';
import 'package:cflash/features/login/domain/repository/login_in_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUser implements UseCase<Login, LoginParams>{
  final LoginRepository repository;
  LoginUser(this.repository);

  @override
  Future<Either<Failure, Login>> call(LoginParams params) async {
    try {
      // Perform the login operation
      final result = await repository.login(params.email, params.password);
      return result; // Return the result of the login operation
    } catch (e) {
      // Handle the exception
      return Left(ServerFailure(e.toString()));
    }
  }
}


class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<dynamic> get props => [email, password];


}


