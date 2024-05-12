//
//
//
// import 'package:cflash/core/usecase/usecase.dart';
// import 'package:cflash/features/subject/domain/entity/subject.dart';
// import 'package:cflash/features/subject/domain/repository/subject_repository.dart';
// import 'package:cflash/features/subject/domain/usecase/viewAllSubject.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockSubjectRepository extends Mock implements SubjectRepository{}
//
//
// void main(){
//   late ViewAllSubject useCase;
//   late MockSubjectRepository mockRepository;
//
//
//   setUp((){
//     mockRepository = MockSubjectRepository();
//     useCase = ViewAllSubject(mockRepository);
//   });
//
//   const title = "Java programming";
//   const description = "instead of teaching you guys J2EE, i will be teaching you guys Java";
//   const lecturer = "Mr Baba Meshack";
//   const List<Subject> tSubject = [Subject(lecturer: lecturer, title: title, description: description),Subject(lecturer: lecturer, title: title, description: description)];
//
//   test('should check if subject views', () async {
//     //arrange
//     when(()=> mockRepository.viewAllSubject()).thenAnswer((_) async=>  const Right(tSubject));
//     // act
//     final result = await useCase(NoParams());
//     // assert
//
//     expect(result,   const Right(tSubject));
//     verify(()=> mockRepository.viewAllSubject());
//     verifyNoMoreInteractions(mockRepository);
//
//   });
//
//
//
// }