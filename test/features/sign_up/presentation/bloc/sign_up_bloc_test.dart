import 'package:cflash/core/error/failure.dart';
import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:cflash/features/sign_up/domain/usecases/register_user.dart';
import 'package:cflash/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterNewUser extends Mock implements RegisterUser {}

class MockBloc extends Mock implements SignUpBloc {}

void main() {
  late SignUpBloc bloc;
  late MockRegisterNewUser mockRegisterNewUser;

  setUpAll(() {
    registerFallbackValue(FakeParams());
  });

  setUp(() {
    mockRegisterNewUser = MockRegisterNewUser();
    bloc = SignUpBloc(registerUser: mockRegisterNewUser);
  });

  test('Test that initial state should be inital state',
      () => {expect(bloc.state, equals(Initial()))});

  group('signup new user', () {
    const uid = '12';
    const email = 'adekanyekabir@gmail.com';
    const userName = 'hiddenKise';
    const password = 'qwerty';
    const tSignUp =
        SignUp(email: email, password: password, userName: userName);

    test('should register new user and call create user', () async {
      //arrange
      when(() => mockRegisterNewUser(any()))
          .thenAnswer((_) async => const Right(tSignUp));
      // act
      bloc.add(const SignUpNewUserEvent(email, password, userName));
      await untilCalled(() => mockRegisterNewUser(any()));
      // assert
      verify(() => mockRegisterNewUser(
          const Params(email: email, password: password, username: userName)));
    });


    test('should emit [loading, Error] when process fails', () async {
      //arrange
      when(() => mockRegisterNewUser(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final expected = [Initial(), Loading(), const Error(message: serverFailureMessage)];
      expectLater(bloc.stream, emitsInOrder(expected));
      // assert
      bloc.add(const SignUpNewUserEvent(email, password, userName));
    });


  });
}

class FakeParams extends Fake implements Params {}
