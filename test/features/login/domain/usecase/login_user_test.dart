import 'package:cflash/core/error/exception.dart';
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/features/login/domain/entity/login.dart';
import 'package:cflash/features/login/domain/repository/login_in_repository.dart';
import 'package:cflash/features/login/domain/usecase/login_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late LoginUser useCase;
  late MockLoginRepository mockLoginRepository;
  setUp(() {
    mockLoginRepository = MockLoginRepository();
    useCase = LoginUser(mockLoginRepository);
  });

  const email = 'adekanyekabir@gmail.com';
  const password = 'qwerty';

  const tLogin = Login(email: email, password: password);

  test('should create user if successful', () async {
    //arrange
    when(() => mockLoginRepository.login(any(), any()))
        .thenAnswer((_) async => const Right(tLogin));
    // act
    final result =
        await useCase(const LoginParams(email: email, password: password));
    // assert
    expect(result, const Right(tLogin));
    verify(() => mockLoginRepository.login(email, password));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
