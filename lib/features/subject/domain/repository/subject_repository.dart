

import 'package:cflash/features/subject/domain/entity/subject.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../login/domain/entity/login.dart';
import '../../data/model/subject_model.dart';

abstract class SubjectRepository{
  Future<Either<Failure, Subject>> addSubject(String title, String description, String lecturer, String image);
  Future<Either<Failure, Subject>> viewSubject();
  Future<Stream<List<SubjectModel>>> viewAllSubject();

}