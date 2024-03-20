
import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';

class SignUpModel extends SignUp{

  const SignUpModel({required String uid,required String email, required String password, required String userName}) : super(email: email, password: password, userName: userName);

  factory SignUpModel.setData(List<String> data){
    return SignUpModel(uid: data[0], email: data[1], password: data[2], userName: data[3]);
  }

}