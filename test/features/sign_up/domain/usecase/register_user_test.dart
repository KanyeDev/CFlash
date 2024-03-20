import 'package:cflash/features/sign_up/domain/entity/sign_up.dart';
import 'package:cflash/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:cflash/features/sign_up/domain/usecases/register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockSignUpRepository extends Mock implements SignUpRepository{}

void main(){
  late  RegisterUser usecase;
  late MockSignUpRepository mockSignUpRepository;

  setUp(() {
    mockSignUpRepository = MockSignUpRepository();
    usecase = RegisterUser(mockSignUpRepository);
  });

  const email = 'adekanyekabir@gmail.com';
  const password = 'qwerty';
  const userName = 'Adekanye Abdulkabir';
  const tSignUp = SignUp(email: email, password: password, userName: userName);

  test('should register user', () async{
    //arrange
    when(() => mockSignUpRepository.registerUser(email, password, userName)).thenAnswer((_) async => const Right(tSignUp) );
    //act
    final result = await usecase(const Params(email: email, password: password, username: userName));

    //assert

    expect(result, const Right(tSignUp));
    verify(() => mockSignUpRepository.registerUser(email, password, userName));
    verifyNoMoreInteractions(mockSignUpRepository);
  });

}