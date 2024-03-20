
import 'package:equatable/equatable.dart';

class Subject extends Equatable{
  final String title;
  final String description;
  final String lecturer;

  const Subject({required this.lecturer, required this.title, required this.description});

  @override
  List<Object?> get props => [title, description, lecturer];

}