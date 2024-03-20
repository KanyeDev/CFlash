part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class Initial extends SignUpState {
  @override
  List<Object> get props => [];
}

class Loading extends SignUpState{
  @override
  List<Object?> get props => [];

}

class Loaded extends SignUpState{
  final SignUp signUp;
  const Loaded({required this.signUp});
  @override
  List<Object?> get props => [signUp];

}

class Error extends SignUpState{
  final String message;
 const Error({required this.message});
  @override
  List<String> get props => [message];

}
