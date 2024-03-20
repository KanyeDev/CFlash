import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/usecase/usecase.dart';
import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:cflash/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class CreateUser implements UseCase<SignUp, Params>{
  final SignUpRepository repository;
  CreateUser(this.repository);

  @override
  Future<Either<Failure, SignUp>> call(Params params) async{
   return await repository.createUser(params.uid, params.username, params.email);
  }
}






class Params extends Equatable {

  final String uid;
  final String username;
  final String email;

  const Params({required this.uid, required this.username,required this.email,});

  @override
  List<dynamic> get props => [uid, username, email];


}
