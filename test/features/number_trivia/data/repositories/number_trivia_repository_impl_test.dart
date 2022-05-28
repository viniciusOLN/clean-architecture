import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:trivia_app/core/plataform/network_info.dart';
import 'package:trivia_app/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:trivia_app/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:trivia_app/features/number_trivia/data/repositories/number_trivia_repository_imp.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([NumberTriviaLocalDatasource])
@GenerateMocks([NumberTriviaRemoteDatasource])
@GenerateMocks([NetworkInfo])
void main() {
  NumberTriviaRepositoryImplementation repository;
  MockNumberTriviaLocalDatasource mockNumberTriviaLocalDatasource;
  MockNumberTriviaRemoteDatasource mockNumberTriviaRemoteDatasource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNumberTriviaRemoteDatasource = MockNumberTriviaRemoteDatasource();
    mockNumberTriviaLocalDatasource = MockNumberTriviaLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImplementation(
      remoteDataSource: mockNumberTriviaRemoteDatasource,
      localDataSource: mockNumberTriviaLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });
}
