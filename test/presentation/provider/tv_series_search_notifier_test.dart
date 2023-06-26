import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late TvSeriesSearchNotifier notifier;
  late int listenerCallCount;

  final TvSeries dummyTvSeries = tvSeriesSearchTest;
  final List<TvSeries> dummyTvSeriesList = [dummyTvSeries];
  final String dummyQuery = 'naruto';

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    notifier = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockSearchTvSeries.execute(dummyQuery))
        .thenAnswer((_) async => Right(dummyTvSeriesList));

    // act
    notifier.fetchTvSeriesSearch(dummyQuery);

    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully', () async {
    // arrange
    when(mockSearchTvSeries.execute(dummyQuery))
        .thenAnswer((_) async => Right(dummyTvSeriesList));

    // act
    await notifier.fetchTvSeriesSearch(dummyQuery);

    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.searchResult, dummyTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockSearchTvSeries.execute(dummyQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    // act
    await notifier.fetchTvSeriesSearch(dummyQuery);

    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
