

import 'package:cflash/core/error/exception.dart';
import 'package:cflash/core/error/failure.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/features/login/presentation/bloc/login_bloc.dart';
import 'package:cflash/features/subject/data/data%20source/subject_data_source.dart';
import 'package:cflash/features/subject/domain/entity/subject.dart';
import 'package:cflash/features/subject/domain/repository/subject_repository.dart';
import 'package:dartz/dartz.dart';

import '../model/subject_model.dart';

class SubjectRepositoryImpl implements SubjectRepository{
  final SubjectDataSource subjectDataSource;
  SubjectRepositoryImpl({required this.subjectDataSource});


  @override
  Future<Either<Failure, Subject>> addSubject(String title, String description, String lecturer, String image) async{
    try{
      final addSubject = await subjectDataSource.addSubject(title, description, lecturer, image);
      return Right(addSubject);
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Subject>> viewSubject() async{
    try{
      final viewSubject = await subjectDataSource.viewSubject();
      return Right(viewSubject);
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future< Stream<List<SubjectModel>>> viewAllSubject() async{

      Stream<List<SubjectModel>> viewAllSubject = subjectDataSource.viewAllSubject();
      return viewAllSubject;

  }


}