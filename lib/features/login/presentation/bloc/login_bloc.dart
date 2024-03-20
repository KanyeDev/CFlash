import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cflash/features/login/domain/usecase/login_user.dart';
import 'package:cflash/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/login.dart';

part 'login_event.dart';
part 'login_state.dart';

const String serverFailureMessage = "Server Failure";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  LoginBloc({required this.loginUser}) : super(Initial()) {
    on<LoginUserEvent>(loginNewUserEventFunction);
  }


  FutureOr<void> loginNewUserEventFunction(LoginUserEvent event, Emitter<LoginState> emit) async{
    emit(Initial());
    emit(Loading());
    final failureOrLogin = await loginUser(LoginParams(email: event.email, password: event.password));
    await failureOrLogin.fold((failure) async{
      emit(const Error(message: serverFailureMessage));
    }, (login) async{
      emit(Loaded(login: login));
    });
  }
}
