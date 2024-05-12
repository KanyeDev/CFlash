// import 'package:cflash/features/subject/domain/entity/subject.dart';
// import 'package:cflash/features/subject/domain/repository/subject_repository.dart';
// import 'package:cflash/features/subject/domain/usecase/add_subject.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockSubjectRepository extends Mock implements SubjectRepository {}
//
// void main() {
//   late AddSubject useCase;
//   late MockSubjectRepository mockSubjectRepository;
//
//   setUp(() {
//     mockSubjectRepository = MockSubjectRepository();
//     useCase = AddSubject(mockSubjectRepository);
//   });
//
//   const title = "Java programming";
//   const description =
//       "instead of teaching you guys J2EE, i will be teaching you guys Java";
//   const lecturer = "Mr Baba Meshack";
//
//   const tSubject =
//       Subject(lecturer: lecturer, title: title, description: description);
//
//   test('should check if subject added', () async {
//     //arrange
//     when(() => mockSubjectRepository.addSubject(any(), any(), any()))
//         .thenAnswer((_) async => const Right(tSubject));
//     // act
//     final result = await useCase(
//         const SubjectParams(lecturer: lecturer, title: title, description: description));
//     // assert
//     expect(result, const Right(tSubject));
//     verify(
//         () => mockSubjectRepository.addSubject(title, description, lecturer));
//     verifyNoMoreInteractions(mockSubjectRepository);
//   });
// }
