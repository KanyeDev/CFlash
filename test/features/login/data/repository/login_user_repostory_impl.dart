// import 'package:cflash/core/error/exception.dart';
// import 'package:cflash/core/error/failure.dart';
// import 'package:cflash/features/login/data/data%20source/login_data_source.dart';
// import 'package:cflash/features/login/data/model/login_in_model.dart';
// import 'package:cflash/features/login/data/repository/login_repository_impl.dart';
// import 'package:cflash/features/login/domain/usecase/login_user.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockLoginDataSource extends Mock implements LoginDataSource {}
//
// void main() {
//   late MockLoginDataSource mockLoginDataSource;
//   late LoginRepositoryImpl repository;
//
//   setUp(() {
//     mockLoginDataSource = MockLoginDataSource();
//     repository = LoginRepositoryImpl(loginDataSource: mockLoginDataSource);
//   });
//
//   const email = 'adekanyekabir@gmail.com';
//   const password = 'qwerty';
//   const tLoginModel = LoginModel(email: email, password: password);
//
//   test('should login user if successful', () async {
//     //arrange
//     when(() => mockLoginDataSource.loginUser(any(), any()))
//         .thenAnswer((invocation) async => tLoginModel);
//     //act
//     final result = await repository.login(email, password);
//     //assert
//     expect(result, const Right(tLoginModel));
//     verify(() => mockLoginDataSource.loginUser(email, password));
//     verifyNoMoreInteractions(mockLoginDataSource);
//   });
//
//   test('should return failure if not successful', () async {
//     //arrange1
//     when(() => mockLoginDataSource.loginUser(email, password))
//         .thenThrow(ServerException());
//     // act
//     final result = await repository.login(email, password);
//     // assert
//     expect(result, Left(ServerFailure()));
//     verify(() => mockLoginDataSource.loginUser(email, password));
//     verifyNoMoreInteractions(mockLoginDataSource);
//   });
// }
