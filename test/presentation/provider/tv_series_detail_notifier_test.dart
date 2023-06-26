import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late int listenerCallCount;

  final int dummyId = 31910;

  final TvSeriesDetail dummyDetailTvSeries = tvSeriesDetailTest;
  final TvSeries dummyTvSeriesRecommendations = tvSeriesRecommendationTest;
  final List<TvSeries> dummyTvSeriesRecommendationsList = [
    dummyTvSeriesRecommendations
  ];

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    provider = TvSeriesDetailNotifier(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchListTvSeriesStatus,
      saveWatchlist: mockSaveWatchlistTvSeries,
      removeWatchlist: mockRemoveWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(dummyId))
        .thenAnswer((_) async => Right(dummyDetailTvSeries));
    when(mockGetTvSeriesRecommendations.execute(dummyId))
        .thenAnswer((_) async => Right(dummyTvSeriesRecommendationsList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvSeriesDetail(dummyId);

      // assert
      verify(mockGetTvSeriesDetail.execute(dummyId));
      verify(mockGetTvSeriesRecommendations.execute(dummyId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();

      // act
      provider.fetchTvSeriesDetail(dummyId);

      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvSeriesDetail(dummyId);

      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, dummyDetailTvSeries);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvSeriesDetail(dummyId);

      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(
          provider.tvSeriesRecommendations, dummyTvSeriesRecommendationsList);
    });
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvSeriesDetail(dummyId);

      // assert
      verify(mockGetTvSeriesRecommendations.execute(dummyId));
      expect(
          provider.tvSeriesRecommendations, dummyTvSeriesRecommendationsList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();

      // act
      await provider.fetchTvSeriesDetail(dummyId);

      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(
          provider.tvSeriesRecommendations, dummyTvSeriesRecommendationsList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(dummyId))
          .thenAnswer((_) async => Right(dummyDetailTvSeries));
      when(mockGetTvSeriesRecommendations.execute(dummyId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      // act
      await provider.fetchTvSeriesDetail(dummyId);

      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListTvSeriesStatus.execute(1))
          .thenAnswer((_) async => true);

      // act
      await provider.loadWatchlistStatus(1);

      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(dummyDetailTvSeries))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListTvSeriesStatus.execute(dummyDetailTvSeries.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(dummyDetailTvSeries);

      // assert
      verify(mockSaveWatchlistTvSeries.execute(dummyDetailTvSeries));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvSeries.execute(dummyDetailTvSeries))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListTvSeriesStatus.execute(dummyDetailTvSeries.id))
          .thenAnswer((_) async => false);

      // act
      await provider.removeFromWatchlist(dummyDetailTvSeries);

      // assert
      verify(mockRemoveWatchlistTvSeries.execute(dummyDetailTvSeries));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(dummyDetailTvSeries))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListTvSeriesStatus.execute(dummyDetailTvSeries.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(dummyDetailTvSeries);

      // assert
      verify(mockGetWatchListTvSeriesStatus.execute(dummyDetailTvSeries.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(dummyDetailTvSeries))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTvSeriesStatus.execute(dummyDetailTvSeries.id))
          .thenAnswer((_) async => false);

      // act
      await provider.addWatchlist(dummyDetailTvSeries);

      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(dummyId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendations.execute(dummyId))
          .thenAnswer((_) async => Right(dummyTvSeriesRecommendationsList));

      // act
      await provider.fetchTvSeriesDetail(dummyId);

      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
