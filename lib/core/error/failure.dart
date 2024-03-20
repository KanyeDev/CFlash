import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final List properties;

  const Failure(String string, {this.properties = const <dynamic>[]});

  @override
  List<dynamic> get props => properties;
}

class ServerFailure extends Failure {
  const ServerFailure(super.string);
}