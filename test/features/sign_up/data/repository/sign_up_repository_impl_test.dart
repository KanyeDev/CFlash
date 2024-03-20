
import 'package:cflash/core/error/exception.dart';
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/features/sign_up/data/model/sign_up_model.dart';
import 'package:cflash/features/sign_up/data/repository/sign_up_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cflash/features/sign_up/data/data%20source/sign_up_data_source.dart';

class MockSignUpDataSource extends Mock implements SignUpDataSource{}

void main(){
  late SignUpRepositoryImpl repository;
  late MockSignUpDataSource mockSignUpDataSource;

  setUp(() {
    mockSignUpDataSource = MockSignUpDataSource();
    repository = SignUpRepositoryImpl(signUpDataSource: mockSignUpDataSource);
  });

  group('Create user', () {

    const uid = '12';
    const email = 'adekanyekabir@gmail.com';
    const userName ='hiddenKise';
    const password = '-';
    const tSignUpModel = SignUpModel(uid: uid, email: email, password: password, userName: userName);
    test('should create new user when call is successful', () async{
      //arrange
      when(() => mockSignUpDataSource.createUser(any(), any(), any())).thenAnswer((_) async => tSignUpModel);
      //act
      final result = await repository.createUser(uid, userName, email);
      //assert

      verify(()=> mockSignUpDataSource.createUser(uid, userName, email));
      expect(result, equals(const Right(tSignUpModel)));
    });

    test('should return failure if create user fails', () async{
      //arrange
      when(() => mockSignUpDataSource.createUser(any(), any(), any())).thenThrow(ServerException());
      //act
      final result = await repository.createUser(uid, userName, email);
      //assert
      verify(()=> mockSignUpDataSource.createUser(uid, userName, email));
      expect(result, Left(ServerFailure()));
    });

  });

group('Register user', () {

    const uid = '12';
    const email = 'adekanyekabir@gmail.com';
    const userName ='hiddenKise';
    const password = '-';
    const tSignUpModel = SignUpModel(uid: uid, email: email, password: password, userName: userName);
    test('should register new user when call is successful', () async{
      //arrange
      when(() => mockSignUpDataSource.registerUser(any(), any(), any())).thenAnswer((_) async => tSignUpModel);
      //act
      final result = await repository.registerUser(email, password, userName);
      //assert

      verify(()=> mockSignUpDataSource.registerUser(email, password, userName));
      expect(result, equals(const Right(tSignUpModel)));
    });

    test('should return failure if create user fails', () async{
      //arrange
      when(() => mockSignUpDataSource.registerUser(any(), any(), any())).thenThrow(ServerException());  ;
      //act
      final result = await repository.registerUser(email, password, userName);
      //assert
      verify(()=> mockSignUpDataSource.registerUser(email, password, userName));
      expect(result, Left(ServerFailure()));
    });

  });

}