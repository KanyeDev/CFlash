// import 'package:cflash/core/error/failure.dart';
// import 'package:cflash/features/login/domain/entity/login.dart';
// import 'package:cflash/features/login/domain/usecase/login_user.dart';
// import 'package:cflash/features/login/presentation/bloc/login_bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockLoginUser extends Mock implements LoginUser {}
//
// class MockBlock extends Mock implements LoginBloc {}
//
// void main() {
//   late LoginBloc bloc;
//   late MockLoginUser mockLoginUser;
//
//   setUpAll(() => registerFallbackValue(FakeParams()));
//
//   setUp(() {
//     mockLoginUser = MockLoginUser();
//     bloc = LoginBloc(loginUser: mockLoginUser);
//   });
//
//   test('should test that initial state is [Initial]',
//       () => {expect(bloc.state, equals(Initial()))});
//
//   group('Login User', () {
//     const email = 'adekanyekabir@gmail.com';
//     const password = 'qwerty';
//     const tLogin = Login(email: email, password: password);
//     test('should login user if successful', () async {
//       //arrange
//       when(() => mockLoginUser(any()))
//           .thenAnswer((invocation) async => const Right(tLogin));
//       // act
//       bloc.add(const LoginUserEvent(email, password));
//       await untilCalled(() => mockLoginUser(any()));
//       // assert
//       verify(() =>
//           mockLoginUser(const LoginParams(email: email, password: password)));
//     });
//
//     test('should return error if failed', () async {
//       //arrange
//       when(() => mockLoginUser(any()))
//           .thenAnswer((invocation) async => Left(ServerFailure()));
//
//       // act
//       final expected = [
//         Initial(),
//         Loading(),
//         const Error(message: serverFailureMessage)
//       ];
//       expectLater(bloc.stream, emitsInOrder(expected));
//       // assert
//       bloc.add(const LoginUserEvent(email, password));
//     });
//   });
// }
//
// class FakeParams extends Fake implements LoginParams {}
