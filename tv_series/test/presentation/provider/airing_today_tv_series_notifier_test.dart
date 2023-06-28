import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries])
void main() {
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late AiringTodayTvSeriesNotifier notifier;
  late int listenerCallCount;

  const TvSeries dummyTvSeries = tvSeriesTest;
  final List<TvSeries> dummyTvSeriesList = [dummyTvSeries];

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    notifier = AiringTodayTvSeriesNotifier(mockGetAiringTodayTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetAiringTodayTvSeries.execute())
        .thenAnswer((_) async => Right(dummyTvSeriesList));

    // act
    notifier.fetchAiringTodayTvSeries();

    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetAiringTodayTvSeries.execute())
        .thenAnswer((_) async => Right(dummyTvSeriesList));

    // act
    await notifier.fetchAiringTodayTvSeries();

    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, dummyTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetAiringTodayTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    // act
    await notifier.fetchAiringTodayTvSeries();

    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}