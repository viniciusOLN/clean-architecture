import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:trivia_app/core/usecases/usecases.dart';
import 'package:trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  // initialization outside of setUp
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  final mockNumberTriviaRepository = MockNumberTriviaRepository();
  final usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);

  group('randomTriviaNumber: ', () {
    test(
      'should get trivia from the repository',
      () async {
        //arrange
        when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer(
          (_) async => const Right(tNumberTrivia),
        );
        // act
        final result = await usecase(NoParams());
        // assert
        expect(result, const Right(tNumberTrivia));
        verify(mockNumberTriviaRepository.getRandomNumberTrivia());
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      },
    );
  });
}
