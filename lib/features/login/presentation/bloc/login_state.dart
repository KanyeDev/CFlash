part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class Initial extends LoginState {
  @override
  List<Object> get props => [];
}

class Loading extends LoginState {
  @override
  List<Object> get props => [];
}

class Loaded extends LoginState {
  final Login login;
  const Loaded({required this.login});
  @override
  List<Object> get props => [login];
}

class Error extends LoginState {
  final String message;

  const Error({required this.message});
  @override
  List<String> get props => [message];
}
