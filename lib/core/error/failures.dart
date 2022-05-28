import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure(this.message);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CacheFailure extends Failure {
  final String message;
  const CacheFailure(this.message);

  @override
  List<Object?> get props => throw UnimplementedError();
}
