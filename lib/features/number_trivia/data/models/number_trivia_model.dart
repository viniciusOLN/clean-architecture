import 'package:trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required int number,
    required String text,
  }) : super(text: text, number: number);
}
