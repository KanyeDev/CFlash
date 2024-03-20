import 'package:equatable/equatable.dart';

class SignUp extends Equatable{
  final String email;
  final String password;
  final String userName;

  const SignUp({
    required this.email,
    required this.password,
    required this.userName
});


  @override
  List<dynamic> get props => [email, password, userName];

}