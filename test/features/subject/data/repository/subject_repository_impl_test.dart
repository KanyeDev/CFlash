//
//
// import 'package:cflash/core/error/exception.dart';
// import 'package:cflash/core/error/failure.dart';
// import 'package:cflash/features/subject/data/data%20source/subject_data_source.dart';
// import 'package:cflash/features/subject/data/model/subject_model.dart';
// import 'package:cflash/features/subject/data/repository/subject_repository_impl.dart';
// import 'package:cflash/features/subject/domain/entity/subject.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockSubjectDataSource extends Mock implements SubjectDataSource{}
//
// void main(){
//   late MockSubjectDataSource mockSubjectDataSource;
//   late SubjectRepositoryImpl repository;
//
//   setUp(() {
//     mockSubjectDataSource = MockSubjectDataSource();
//     repository = SubjectRepositoryImpl(subjectDataSource: mockSubjectDataSource);
//   });
//
//   const title = "Java programming";
//   const description = "instead of teaching you guys J2EE, i will be teaching you guys Java";
//   const lecturer = "Mr Baba Meshack";
//
//
//   group("add subject", () {
//     const tSubjectModel = SubjectModel(title: title, description: description, lecturer: lecturer);
//     const Subject tsubject = tSubjectModel;
//     test('should store data if successful', ()async{
//       //arrange
//       when(()=> mockSubjectDataSource.addSubject(any(), any(), any())).thenAnswer((_) async=> tSubjectModel);
//       //act
//       final result = await repository.addSubject(title, description, lecturer);
//       //assert
//       expect(result, const Right(tsubject));
//       verify(()=> mockSubjectDataSource.addSubject(title, description, lecturer));
//       verifyNoMoreInteractions(mockSubjectDataSource);
//     });
//
//
//     test('should return failure if not successful', ()async{
//       //arrange
//       when(()=> mockSubjectDataSource.addSubject(any(), any(), any())).thenThrow(ServerException());
//       //act
//       final result = await repository.addSubject(title, description, lecturer);
//       //assert
//       expect(result, Left(ServerFailure()));
//       verify(()=> mockSubjectDataSource.addSubject(title, description, lecturer));
//       verifyNoMoreInteractions(mockSubjectDataSource);
//
//     });
//   });
//
//
//   group("view subject", () {
//     const tSubjectModel = SubjectModel(title: title, description: description, lecturer: lecturer);
//     const Subject tsubject = tSubjectModel;
//     test('should view data if successful', ()async{
//       //arrange
//       when(()=> mockSubjectDataSource.viewSubject()).thenAnswer((_) async=> tSubjectModel);
//       //act
//       final result = await repository.viewSubject();
//       //assert
//       verify(()=> mockSubjectDataSource.viewSubject());
//       expect(result, const Right(tsubject));
//     });
//
//
//     test('should return failure if not successful', ()async{
//       //arrange
//       when(()=> mockSubjectDataSource.viewSubject()).thenThrow(ServerException());
//       //act
//       final result = await repository.viewSubject();
//       //assert
//       verify(()=> mockSubjectDataSource.viewSubject());
//       expect(result, Left(ServerFailure()));
//       verifyNoMoreInteractions(mockSubjectDataSource);
//
//     });
//   });
//
//   group("view All subject", () {
//     final tSubjectModel = [
//       SubjectModel(lecturer: 'Test Lecturer 1', title: 'Test Title 1', description: 'Test Description 1'),
//       SubjectModel(lecturer: 'Test Lecturer 2', title: 'Test Title 2', description: 'Test Description 2')
//     ];
//
//     test('should emit data if successful', () async {
//       // Arrange
//       when(mockSubjectDataSource.viewAllSubject()).thenAnswer((_) => Stream.value(tSubjectModel));
//
//       // Act
//       bloc.fetchSubjects(); // Trigger fetching subjects
//
//       // Assert
//       await expectLater(bloc.subjectStream, emitsInOrder([tSubjectModel]));
//     });
//
//     test('should emit error if unsuccessful', () async {
//       // Arrange
//       final errorMessage = 'Error fetching subjects';
//       when(mockSubjectDataSource.viewAllSubject()).thenThrow(errorMessage);
//
//       // Act
//       bloc.fetchSubjects(); // Trigger fetching subjects
//
//       // Assert
//       await expectLater(bloc.subjectStream, emitsError(errorMessage));
//     });
//
//     test('should return failure if not successful', ()async{
//       //arrange
//       when(()=> mockSubjectDataSource.viewAllSubject()).thenThrow(ServerException());
//       //act
//       final result = await repository.viewAllSubject();
//       //assert
//       verify(()=> mockSubjectDataSource.viewAllSubject());
//       expect(result, Left(ServerFailure()));
//       verifyNoMoreInteractions(mockSubjectDataSource);
//
//     });
//   });
// }
//
