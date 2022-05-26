import 'package:dartz/dartz.dart';
import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/usecases/usecases.dart';
import 'package:trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/features/number_trivia/domain/repositories/number_trivia.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository respository;

  GetRandomNumberTrivia(this.respository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await respository.getRandomNumberTrivia();
  }
}
