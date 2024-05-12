// import 'package:bloc/bloc.dart';
// import 'package:cflash/core/error/failure.dart';
// import 'package:cflash/core/usecase/usecase.dart';
// import 'package:cflash/features/sign_up/domain/usecases/create_user.dart';
// import 'package:cflash/features/subject/domain/entity/subject.dart';
// import 'package:cflash/features/subject/domain/usecase/add_subject.dart';
// import 'package:cflash/features/subject/domain/usecase/viewAllSubject.dart';
// import 'package:cflash/features/subject/domain/usecase/viewSubject.dart';
// import 'package:cflash/features/subject/presentation/bloc/subject_bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// import '../../login/presentation/bloc/login_bloc_test.dart';
//
// class MockAddSubject extends Mock implements AddSubject {}
//
// class MockViewSubject extends Mock implements ViewSubject {}
//
// class MockViewAllSubject extends Mock implements ViewAllSubject {}
//
// class MockBloc extends Mock implements SubjectBloc {}
//
// void main() {
//   late SubjectBloc bloc;
//
//   late MockAddSubject mockAddSubject;
//   late MockViewSubject mockViewSubject;
//   late MockViewAllSubject mockViewAllSubject;
//
//   const String serverFailureMessage = "Server Failure";
//
//   const title = "Java programming";
//   const description =
//       "instead of teaching you guys J2EE, i will be teaching you guys Java";
//   const lecturer = "Mr Baba Meshack";
//
//   setUpAll(() {
//     registerFallbackValue(FakeParams());
//     registerFallbackValue(FakeNoParams());
//     registerFallbackValue(const SubjectParams(
//         lecturer: lecturer, title: title, description: description));
//     registerFallbackValue(
//         const AddSubjectEvent("subject", "decription", "lecturer"));
//     registerFallbackValue(MyTypeFake());
//   });
//
//   setUp(() {
//     mockAddSubject = MockAddSubject();
//     mockViewSubject = MockViewSubject();
//     mockViewAllSubject = MockViewAllSubject();
//     bloc = SubjectBloc(
//         addSubject: mockAddSubject,
//         viewSubject: mockViewSubject,
//         viewAllSubject: mockViewAllSubject);
//   });
//
//   group("test all the initials", () {
//     test('Test that initial state should be inital state on',
//         () => {expect(bloc.state, equals(Initial()))});
//   });
//
//   const tAddSubject =
//       Subject(lecturer: lecturer, title: title, description: description);
//
//   ///ADD SUBJECT TEST
//   group("Add subject test", () {
//     test("should add subject", () async* {
//       //arrange
//       when(() => mockAddSubject(any()))
//           .thenAnswer((_) async => const Right(tAddSubject));
//
//       //act
//       bloc.add(const AddSubjectEvent(title, description, lecturer));
//       await untilCalled(() => mockAddSubject!(any())); // Assert
//
//       verify(() => mockAddSubject(const SubjectParams(
//           lecturer: lecturer,
//           title: title,
//           description: description))).called(1);
//
//       //verifyNoMoreInteractions(mockAddSubject);
//     });
//
//     test('should emit [Loading, Loaded] when data is added successfully ',
//         () async* {
//       //arrange
//       when(() => mockAddSubject(any()))
//           .thenAnswer((invocation) async => const Right(tAddSubject));
//
//       //act
//       bloc.add(const AddSubjectEvent(title, description, lecturer));
//       //assert later
//       final expected = [
//         Initial(),
//         Loading(),
//         const AddSubjectLoaded(subject: tAddSubject)
//       ];
//
//       expectLater(bloc.stream, emitsInOrder(expected));
//     });
//
//     test("should emit [Loading, Error] when process fail", () async {
//       //arrange
//       when(() => mockAddSubject(any()))
//           .thenAnswer((_) async => Left(ServerFailure()));
//       //act
//       final expected = [
//         Initial(),
//         Loading(),
//         const Error(message: serverFailureMessage)
//       ];
//       expectLater(bloc.stream, emitsInOrder(expected));
//       //assert
//       bloc.add(const AddSubjectEvent(title, description, lecturer));
//     });
//   });
//
//   ///VIEW ALL SUBJECT TEST
//
//   group('View subject test', () {
//     test('should view subject', () async {
//       //arrange
//       when(() => mockViewSubject(any()))
//           .thenAnswer((invocation) async => const Right(tAddSubject));
//
//       // act
//
//       bloc.add(ViewSubjectEvent());
//       await untilCalled(() => mockViewSubject(any()));
//
//       // assert
//       verify(() => mockViewSubject(NoParams()));
//     });
//
//     test("should emit [Loading, Loaded] when data gotten succesfully",
//         () async {
//       //arrange
//       when(() => mockViewSubject(any()))
//           .thenAnswer((invocation) async => const Right(tAddSubject));
//
//       //assert later
//       final expected = [Initial(), Loading(), ViewSubjectLoaded()];
//       expectLater(bloc.stream, emitsInOrder(expected));
//       //act
//       bloc.add(ViewSubjectEvent());
//     });
//
//     test("should emit [Loading, Error] if there is an error", () async {
//       //arrange
//       when(() => mockViewSubject(any()))
//           .thenAnswer((invocation) async => Left(ServerFailure()));
//
//       //assert later
//       final expected = [
//         Initial(),
//         Loading(),
//         const Error(message: serverFailureMessage)
//       ];
//       expectLater(bloc.stream, emitsInOrder(expected));
//       //act
//       bloc.add(ViewSubjectEvent());
//     });
//   });
//
//   ///VIEW ALL SUBJECTS
//
//   group('View All Subject test', () {
//     test('should view subjects', () async {
//       //arrange
//       when(() => mockViewAllSubject(any())).thenAnswer(
//           (invocation) async => const Right([tAddSubject, tAddSubject]));
//       // act
//       bloc.add(ViewAllSubjectEvent());
//       await untilCalled(() => mockViewAllSubject(any()));
//       // assert
//       verify(() => mockViewAllSubject(NoParams()));
//     });
//
//     test('should emit [Loading, Loaded] if data gotten succesfully', () async {
//       //arrange
//       when(() => mockViewAllSubject(any())).thenAnswer(
//           (invocation) async => const Right([tAddSubject, tAddSubject]));
//
//       // assert later
//       final expected = [Initial(), Loading(), ViewAllSubjectLoaded()];
//       expectLater(bloc.stream, emitsInOrder(expected));
//
//       // act
//
//       bloc.add(ViewAllSubjectEvent());
//     });
//
//     test('should emit [loading, error] if data failed', () async {
//       //arrange
//       when(() => mockViewAllSubject(any()))
//           .thenAnswer((invocation) async => Left(ServerFailure()));
//       // assert later
//       final expected = [Initial(), Loading(), const Error(message: serverFailureMessage)];
//       expectLater(bloc.stream, emitsInOrder(expected));
//       // act
//       bloc.add(ViewAllSubjectEvent());
//     });
//   });
// }
//
// class MyTypeFake extends Fake implements Emitter<SubjectState> {}
//
// class FakeNoParams extends Fake implements Params {}
//
// class FakeParams extends Fake implements NoParams {}
