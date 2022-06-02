import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:trivia_app/core/error/exceptions.dart';
import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/plataform/network_info.dart';
import 'package:trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:trivia_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:trivia_app/features/number_trivia/data/repositories/number_trivia_repository_imp.dart';
import 'package:trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NumberTriviaLocalDatasource])
@GenerateMocks([NumberTriviaRemoteDatasource])
@GenerateMocks([NetworkInfo])
void main() {
  late final MockNumberTriviaLocalDatasource mockNumberTriviaLocalDatasource =
      MockNumberTriviaLocalDatasource();
  MockNumberTriviaRemoteDatasource mockNumberTriviaRemoteDatasource =
      MockNumberTriviaRemoteDatasource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  NumberTriviaRepositoryImplementation repository =
      NumberTriviaRepositoryImplementation(
    remoteDataSource: mockNumberTriviaRemoteDatasource,
    localDataSource: mockNumberTriviaLocalDatasource,
    networkInfo: mockNetworkInfo,
  );

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: 'Test');
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    //teste não passando
    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getConcreteNumberTrivia(tNumber);

      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data source is sucessful',
          () async {
        when(mockNumberTriviaRemoteDatasource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(tNumber);

        verify(
            mockNumberTriviaRemoteDatasource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTrivia)));
      });

      test(
          'should cache the data locally when the call to remote data source is sucessful',
          () async {
        when(mockNumberTriviaRemoteDatasource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(tNumber);

        verify(
            mockNumberTriviaRemoteDatasource.getConcreteNumberTrivia(tNumber));
        verify(mockNumberTriviaLocalDatasource
            .cacheNumberTrivia(tNumberTriviaModel));
        expect(result, equals(Right(tNumberTrivia)));
      });
      test(
          'should return server failure when the call to remote data source is unsucessful',
          () async {
        when(mockNumberTriviaRemoteDatasource.getConcreteNumberTrivia(tNumber))
            .thenThrow(ServerException());

        final result = await repository.getConcreteNumberTrivia(tNumber);

        verify(
          mockNumberTriviaRemoteDatasource.getConcreteNumberTrivia(tNumber),
        );
        verifyZeroInteractions(mockNumberTriviaLocalDatasource);
        expect(result, equals(const Left(ServerFailure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(mockNumberTriviaLocalDatasource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          final result = await repository.getConcreteNumberTrivia(tNumber);

          verifyZeroInteractions(mockNumberTriviaRemoteDatasource);
          verify(mockNumberTriviaLocalDatasource.getLastNumberTrivia());
          expect(result, equals(Right(tNumberTrivia)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          when(mockNumberTriviaLocalDatasource.getLastNumberTrivia())
              .thenThrow(CacheException());

          final result = await repository.getConcreteNumberTrivia(tNumber);

          verifyZeroInteractions(mockNumberTriviaRemoteDatasource);
          verify(mockNumberTriviaLocalDatasource.getLastNumberTrivia());
          expect(result, equals(const Left(CacheFailure())));
        },
      );
    });
  });
}
