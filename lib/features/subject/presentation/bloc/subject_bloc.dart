import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cflash/core/usecase/usecase.dart';
import 'package:cflash/features/subject/domain/entity/subject.dart';
import 'package:cflash/features/subject/domain/usecase/add_subject.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../data/model/subject_model.dart';
import '../../domain/usecase/viewAllSubject.dart';
import '../../domain/usecase/viewSubject.dart';

part 'subject_event.dart';
part 'subject_state.dart';

const String serverFailureMessage = "Server Failure";

//--Add subject Bloc

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final AddSubject addSubject;
  final ViewSubject viewSubject;
  final ViewAllSubject viewAllSubject;

  SubjectBloc({
    required this.addSubject,
    required this.viewSubject,
    required this.viewAllSubject,
  }) : super(Initial()) {
    on<AddSubjectEvent>(addSubjectEventFunction);
    on<ViewSubjectEvent>(viewSubjectEventFunction);
    on<ViewAllSubjectEvent>(_viewAllSubjectEventFunction);
  }

  FutureOr<void> addSubjectEventFunction(AddSubjectEvent event, Emitter<SubjectState> emit) async{

    emit(Initial());
    emit(Loading());
    final failureOrAddSubject = await addSubject(SubjectParams(lecturer: event.lecturer, title: event.title, description: event.description, image: event.image));
    await failureOrAddSubject.fold((failure) async{
      emit(const Error(message: serverFailureMessage));
    }, (subject) async{
      emit(AddSubjectLoaded(subject: subject));
    });
  }

  FutureOr<void> viewSubjectEventFunction(ViewSubjectEvent event, Emitter<SubjectState> emit) async{

    emit(Initial());
    emit(Loading());

    final failureOrViewSubject = await viewSubject(NoParams());
    await failureOrViewSubject.fold((failure) async{
      emit(const Error(message: serverFailureMessage));
    }, (subject) async{
      emit(ViewSubjectLoaded());
    });


  }


  FutureOr<void> _viewAllSubjectEventFunction(
      ViewAllSubjectEvent event, Emitter<SubjectState> emit) async {
    emit(Initial());
    emit(Loading());

    final Stream<List<SubjectModel>> subjectStream = await viewAllSubject(NoParams());

    subjectStream.listen(
          (subjects) {
        emit(ViewAllSubjectLoaded(subjects: subjects));
      },
      onError: (error) {
        emit(const Error(message: serverFailureMessage));
      },
    );
  }
}
