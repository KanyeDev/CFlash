

import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/usecase/usecase.dart';
import 'package:cflash/features/subject/domain/entity/subject.dart';
import 'package:cflash/features/subject/domain/repository/subject_repository.dart';
import 'package:dartz/dartz.dart';

class ViewSubject implements UseCase<Subject, NoParams>{
  final SubjectRepository repository;
  ViewSubject(this.repository);

  @override
  Future<Either<Failure, Subject>> call(NoParams params) async{
    return await repository.viewSubject();
  }


}