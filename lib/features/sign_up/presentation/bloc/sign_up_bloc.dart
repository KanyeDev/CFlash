import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/register_user.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

const String serverFailureMessage = "Server Failure";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  late final RegisterUser registerUser;

  SignUpBloc({required this.registerUser}) : super(Initial()) {
    on<SignUpNewUserEvent>(signUpNewUserEventFunction);
  }

  FutureOr<void> signUpNewUserEventFunction(
      SignUpNewUserEvent event, Emitter<SignUpState> emit) async {
    emit(Initial());
    emit(Loading());
    final failureOrSignup = await registerUser(Params(
        email: event.email,
        password: event.password,
        username: event.userName));
    await failureOrSignup.fold((failure) async {
      emit(const Error(message: serverFailureMessage));
    }, (signUp) async {
      emit(Loaded(signUp: signUp));
    });
  }
}
