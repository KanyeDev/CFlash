import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:cflash/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:cflash/features/sign_up/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockSignUpRepository extends Mock implements SignUpRepository{}

void main(){
  late  CreateUser useCase;
  late MockSignUpRepository mockSignUpRepository;

  setUp(() {
    mockSignUpRepository = MockSignUpRepository();
    useCase = CreateUser(mockSignUpRepository);
  });

  const email = 'adekanyekabir@gmail.com';
  const password = 'qwerty';
  const userName = 'Adekanye Abdulkabir';
  const uid = '123';
  const tSignUp = SignUp(email: email, password: password, userName: userName);

  test('should sign up user', () async{
    //arrange
    when(() => mockSignUpRepository.createUser(uid, userName, email)).thenAnswer((_) async => const Right(tSignUp) );
    //act
    final result = await useCase(const Params(uid: uid, username: userName, email: email));

    //assert

    expect(result, const Right(tSignUp));
    verify(() => mockSignUpRepository.createUser(uid, userName, email));
    verifyNoMoreInteractions(mockSignUpRepository);
  });

}