import 'package:cflash/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseAll<Type, Params>{
  Future< Stream<List<Type>>> call(Params params);
}

class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}