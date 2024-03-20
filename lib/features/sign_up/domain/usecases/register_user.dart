import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/usecase/usecase.dart';
import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:cflash/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class RegisterUser implements UseCase<SignUp, Params>{
  final SignUpRepository repository;
  RegisterUser(this.repository);

  @override
  Future<Either<Failure, SignUp>> call(Params params) async{
    return await repository.registerUser(params.email, params.password, params.username);
  }
}






class Params extends Equatable {

  final String email;
  final String password;
  final String username;

  const Params({required this.email, required this.password,required this.username,});

  @override
  List<dynamic> get props => [email, password, username];


}
