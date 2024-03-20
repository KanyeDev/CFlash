part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpNewUserEvent extends SignUpEvent{
 final String email;
 final String password;
 final String userName;

 const SignUpNewUserEvent(this.email, this.password, this.userName);

  @override
  List<String> get props => [email, password, userName];

}