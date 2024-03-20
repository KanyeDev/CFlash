

import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/usecase/usecase.dart';
import 'package:cflash/features/subject/domain/entity/subject.dart';
import 'package:cflash/features/subject/domain/repository/subject_repository.dart';
import 'package:dartz/dartz.dart';

class AddSubject implements UseCase<Subject, SubjectParams>{
  final SubjectRepository repository;
  AddSubject(this.repository);

  @override
  Future<Either<Failure, Subject>> call(SubjectParams params) async{
    return await repository.addSubject(params.title, params.description, params.lecturer, params.image);
  }


}

class SubjectParams {
  final String title;
  final String description;
  final String lecturer;
  final String image;

  const SubjectParams( { required this.lecturer, required this.title, required this.description, required this.image});

  @override
  List<Object?> get props => [title, description, lecturer, image];
}