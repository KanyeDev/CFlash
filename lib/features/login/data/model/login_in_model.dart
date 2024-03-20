
import '../../domain/entity/login.dart';

class LoginModel extends Login{

  const LoginModel({required super.email, required super.password});

  factory LoginModel.setData(List<String> data){
    return LoginModel(email: data[0], password: data[1]);
  }

}