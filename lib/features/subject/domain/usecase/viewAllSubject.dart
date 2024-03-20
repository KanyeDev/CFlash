

import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/usecase/usecase.dart';
import 'package:cflash/features/subject/domain/entity/subject.dart';
import 'package:cflash/features/subject/domain/repository/subject_repository.dart';
import 'package:dartz/dartz.dart';

import '../../data/model/subject_model.dart';

class ViewAllSubject implements UseCaseAll<Subject, NoParams>{
  final SubjectRepository repository;
  ViewAllSubject(this.repository);

  @override
  Future<Stream<List<SubjectModel>>> call(NoParams params) async{
    return  await repository.viewAllSubject();
  }


}