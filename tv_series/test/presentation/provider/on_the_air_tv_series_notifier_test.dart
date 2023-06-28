import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvSeries])
void main() {
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;
  late OnTheAirTvSeriesNotifier notifier;
  late int listenerCallCount;

  const TvSeries dummyTvSeries = tvSeriesTest;
  final List<TvSeries> dummyTvSeriesList = [dummyTvSeries];

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    notifier = OnTheAirTvSeriesNotifier(mockGetOnTheAirTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetOnTheAirTvSeries.execute())
        .thenAnswer((_) async => Right(dummyTvSeriesList));

    // act
    notifier.fetchOnTheAirTvSeries();

    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetOnTheAirTvSeries.execute())
        .thenAnswer((_) async => Right(dummyTvSeriesList));

    // act
    await notifier.fetchOnTheAirTvSeries();

    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, dummyTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetOnTheAirTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    // act
    await notifier.fetchOnTheAirTvSeries();

    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
