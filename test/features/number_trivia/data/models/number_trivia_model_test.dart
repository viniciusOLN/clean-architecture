import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );
}
