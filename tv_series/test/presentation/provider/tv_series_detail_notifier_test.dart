import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

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

  const int dummyId = 31910;

  const TvSeriesDetail dummyDetailTvSeries = tvSeriesDetailTest;
  const TvSeriesTable dummyTvSeriesTable = tvSeriesTableTest;
  const TvSeries dummyTvSeriesRecommendations = tvSeriesRecommendationTest;
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
        .thenAnswer((_) async => const Right(dummyDetailTvSeries));
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
          .thenAnswer((_) async => const Right(dummyDetailTvSeries));
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
      when(mockSaveWatchlistTvSeries.execute(dummyTvSeriesTable.toJson()))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListTvSeriesStatus.execute(dummyTvSeriesTable.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(dummyTvSeriesTable.toJson());

      // assert
      verify(mockSaveWatchlistTvSeries.execute(dummyTvSeriesTable.toJson()));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvSeries.execute(dummyDetailTvSeries.id))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchListTvSeriesStatus.execute(dummyDetailTvSeries.id))
          .thenAnswer((_) async => false);

      // act
      await provider.removeFromWatchlist(dummyDetailTvSeries.id);

      // assert
      verify(mockRemoveWatchlistTvSeries.execute(dummyDetailTvSeries.id));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(dummyTvSeriesTable.toJson()))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListTvSeriesStatus.execute(dummyTvSeriesTable.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(dummyTvSeriesTable.toJson());

      // assert
      verify(mockGetWatchListTvSeriesStatus.execute(dummyTvSeriesTable.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvSeries.execute(dummyTvSeriesTable.toJson()))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTvSeriesStatus.execute(dummyTvSeriesTable.id))
          .thenAnswer((_) async => false);

      // act
      await provider.addWatchlist(dummyTvSeriesTable.toJson());

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
