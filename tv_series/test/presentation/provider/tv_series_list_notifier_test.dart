import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTvSeries,
  GetOnTheAirTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries
])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  const TvSeries dummyTvSeries = tvSeriesTest;
  final List<TvSeries> dummyTvSeriesList = [dummyTvSeries];

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();

    provider = TvSeriesListNotifier(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
      getOnTheAirTvSeries: mockGetOnTheAirTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('airing today tv series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchAiringTodayTvSeries();

      // assert
      verify(mockGetAiringTodayTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchAiringTodayTvSeries();

      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      await provider.fetchAiringTodayTvSeries();

      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvSeries, dummyTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchAiringTodayTvSeries();

      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('on the air tv series', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchOnTheAirTvSeries();

      // assert
      verify(mockGetOnTheAirTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchOnTheAirTvSeries();

      // assert
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      await provider.fetchOnTheAirTvSeries();

      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTvSeries, dummyTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchOnTheAirTvSeries();

      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('initialState should be Empty', () {
      expect(provider.popularState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchPopularTvSeries();

      // assert
      verify(mockGetPopularTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchPopularTvSeries();

      // assert
      expect(provider.popularState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      await provider.fetchPopularTvSeries();

      // assert
      expect(provider.popularState, RequestState.Loaded);
      expect(provider.popularTvSeries, dummyTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchPopularTvSeries();

      // assert
      expect(provider.popularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('initialState should be Empty', () {
      expect(provider.topRatedState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchTopRatedTvSeries();

      // assert
      verify(mockGetTopRatedTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      provider.fetchTopRatedTvSeries();

      // assert
      expect(provider.topRatedState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      // act
      await provider.fetchTopRatedTvSeries();

      // assert
      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, dummyTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      // act
      await provider.fetchTopRatedTvSeries();

      // assert
      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
