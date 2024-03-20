part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();
}

class AddSubjectEvent extends SubjectEvent{
  final String title;
  final String description;
  final String lecturer;
  final String image;

  const AddSubjectEvent(this.title, this.description, this.lecturer, this.image);

  @override
  List<String> get props => [title, description, lecturer, image];

}

class ViewSubjectEvent extends SubjectEvent{

  @override
  List<String> get props => [];

}


class ViewAllSubjectEvent extends SubjectEvent{

  @override
  List<String> get props => [];

}