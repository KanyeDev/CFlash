part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();
}

class Initial extends SubjectState {
  @override
  List<Object> get props => [];
}

class Loading extends SubjectState{
  @override
  List<Object?> get props => [];

}

class AddSubjectLoaded extends SubjectState{
 final Subject subject;
 const AddSubjectLoaded({required this.subject});

  @override
  List<Object?> get props => [subject];

}

class ViewSubjectLoaded extends SubjectState{


  @override
  List<Object?> get props => [];
}


class ViewAllSubjectLoaded extends SubjectState {
  final List<SubjectModel> subjects;

  const ViewAllSubjectLoaded({required this.subjects});

  @override
  List<Object?> get props => [subjects];
}

class Error extends SubjectState {
  final String message;
  const Error({required this.message});

  @override
  List<String> get props => [message];
}
