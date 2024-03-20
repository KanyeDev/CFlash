
import 'package:cflash/core/error/exception.dart';
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/features/login/data/data%20source/login_data_source.dart';
import 'package:cflash/features/login/domain/entity/login.dart';
import 'package:cflash/features/login/domain/repository/login_in_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository{
  final LoginDataSource loginDataSource;
  LoginRepositoryImpl({required this.loginDataSource});


  @override
  Future<Either<Failure, Login>> login(String email, String password) async{
    try{
      final loginUser = await loginDataSource.loginUser(email, password);
      return loginUser;
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }


}