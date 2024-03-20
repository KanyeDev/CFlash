
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:cflash/features/sign_up/domain/repository/sign_up_repository.dart';

import 'package:dartz/dartz.dart';


import '../../../../core/error/exception.dart';
import '../data source/sign_up_data_source.dart';

class SignUpRepositoryImpl implements SignUpRepository{
  final SignUpDataSource signUpDataSource;

   SignUpRepositoryImpl({required this.signUpDataSource});




  @override
  Future<Either<Failure, SignUp>> createUser(String uid, String userName, String email)async {
      try {
        final createUser = await signUpDataSource.createUser(uid, userName, email);
        return Right(createUser);
      }catch(e){
        return Left(ServerFailure(e.toString()));
    }

  }

  @override
  Future<Either<Failure, SignUp>> registerUser(String email, String password, String userName) async{
  try{
    final register = await signUpDataSource.registerUser(email, password, userName);
    return Right(register);
  }catch(e){
    return Left(ServerFailure(e.toString()));
  }

  }

}