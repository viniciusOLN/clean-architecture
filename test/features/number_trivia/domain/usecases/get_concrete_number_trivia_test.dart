import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_app/core/usecases/usecases.dart';
import 'package:trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/annotations.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  // initialization outside of setUp
  const tNumber = 5;
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  final mockNumberTriviaRepository = MockNumberTriviaRepository();
  final usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);

  group('triviaNumber: ', () {
    test(
      'should get trivia for the number from the repository',
      () async {
        //arrange
        when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        // act
        final result = await usecase(const Params(tNumber));
        // assert
        expect(result, const Right(tNumberTrivia));
        verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      },
    );
  });
}
