import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockTvSeriesRemoteDataSource;
  late MockTvSeriesLocalDataSource mockTvSeriesLocalDataSource;

  const TvSeries dummyTvSeries = tvSeriesTest;
  const TvSeriesModel dummyTvSeriesModel = tvSeriesModelTest;

  const TvSeries dummyTvSeriesRecommendations = tvSeriesRecommendationTest;
  const TvSeriesModel dummyTvSeriesModelRecommendations =
      tvSeriesModelRecommendationTest;

  const TvSeries dummyTvSeriesSearch = tvSeriesSearchTest;
  const TvSeriesModel dummyTvSeriesModelSearch = tvSeriesModelSearchTest;

  const TvSeriesDetail dummyDetailTvSeries = tvSeriesDetailTest;
  const TvSeriesDetailModel dummyDetailTvSeriesModel = tvSeriesDetailModelTest;

  final List<TvSeries> dummyTvSeriesList = [dummyTvSeries];
  final List<TvSeriesModel> dummyTvSeriesModelList = [dummyTvSeriesModel];

  final List<TvSeries> dummyTvSeriesRecommendationsList = [
    dummyTvSeriesRecommendations
  ];
  final List<TvSeriesModel> dummyTvSeriesModelRecommendationsList = [
    dummyTvSeriesModelRecommendations
  ];

  final List<TvSeries> dummyTvSeriesSearchList = [dummyTvSeriesSearch];
  final List<TvSeriesModel> dummyTvSeriesModelSearchList = [
    dummyTvSeriesModelSearch
  ];

  const int dummyId = 31910;
  const String dummyQuery = 'naruto';

  const TvSeriesTable dummyTvSeriesTable = tvSeriesTableTest;
  final TvSeries tvSeriesFromDb = TvSeries(
    id: dummyTvSeriesTable.id,
    name: dummyTvSeriesTable.name,
    posterPath: dummyTvSeriesTable.posterPath,
    overview: dummyTvSeriesTable.overview,
  );

  setUp(() {
    mockTvSeriesRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockTvSeriesLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      localDataSource: mockTvSeriesLocalDataSource,
      remoteDataSource: mockTvSeriesRemoteDataSource,
    );
  });

  group('airing today tv series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getAiringTodayTvSeries())
          .thenAnswer((_) async => dummyTvSeriesModelList);

      // act
      final result = await repository.getAiringTodayTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getAiringTodayTvSeries());
      final resultList = result.getOrElse(() => dummyTvSeriesList);
      expect(resultList, dummyTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(ServerException());

      // act
      final result = await repository.getAiringTodayTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getAiringTodayTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getAiringTodayTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getAiringTodayTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('on the air tv series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getOnTheAirTvSeries())
          .thenAnswer((_) async => dummyTvSeriesModelList);

      // act
      final result = await repository.getOnTheAirTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getOnTheAirTvSeries());
      final resultList = result.getOrElse(() => dummyTvSeriesList);
      expect(resultList, dummyTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getOnTheAirTvSeries())
          .thenThrow(ServerException());

      // act
      final result = await repository.getOnTheAirTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getOnTheAirTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getOnTheAirTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getOnTheAirTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getOnTheAirTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('popular tv series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => dummyTvSeriesModelList);

      // act
      final result = await repository.getPopularTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getPopularTvSeries());
      final resultList = result.getOrElse(() => dummyTvSeriesList);
      expect(resultList, dummyTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());

      // act
      final result = await repository.getPopularTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getPopularTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getPopularTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getPopularTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('top rated tv series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => dummyTvSeriesModelList);

      // act
      final result = await repository.getTopRatedTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getTopRatedTvSeries());
      final resultList = result.getOrElse(() => dummyTvSeriesList);
      expect(resultList, dummyTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());

      // act
      final result = await repository.getTopRatedTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getTopRatedTvSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getTopRatedTvSeries();

      // assert
      verify(mockTvSeriesRemoteDataSource.getTopRatedTvSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('tv series detail', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(dummyId))
          .thenAnswer((_) async => dummyDetailTvSeriesModel);

      // act
      final result = await repository.getTvSeriesDetail(dummyId);

      // assert
      verify(mockTvSeriesRemoteDataSource.getTvSeriesDetail(dummyId));
      final resultDetail = result.getOrElse(() => dummyDetailTvSeries);
      expect(resultDetail, dummyDetailTvSeries);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(dummyId))
          .thenThrow(ServerException());

      // act
      final result = await repository.getTvSeriesDetail(dummyId);

      // assert
      verify(mockTvSeriesRemoteDataSource.getTvSeriesDetail(dummyId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesDetail(dummyId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getTvSeriesDetail(dummyId);

      // assert
      verify(mockTvSeriesRemoteDataSource.getTvSeriesDetail(dummyId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('tv series recommendation', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(dummyId))
          .thenAnswer((_) async => dummyTvSeriesModelRecommendationsList);

      // act
      final result = await repository.getTvSeriesRecommendations(dummyId);

      // assert
      verify(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(dummyId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, dummyTvSeriesRecommendationsList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(dummyId))
          .thenThrow(ServerException());

      // act
      final result = await repository.getTvSeriesRecommendations(dummyId);

      // assert
      verify(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(dummyId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(dummyId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.getTvSeriesRecommendations(dummyId);

      // assert
      verify(mockTvSeriesRemoteDataSource.getTvSeriesRecommendations(dummyId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('search tv series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(dummyQuery))
          .thenAnswer((_) async => dummyTvSeriesModelSearchList);

      // act
      final result = await repository.searchTvSeries(dummyQuery);

      // assert
      verify(mockTvSeriesRemoteDataSource.searchTvSeries(dummyQuery));
      final resultList = result.getOrElse(() => []);
      expect(resultList, dummyTvSeriesSearchList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(dummyQuery))
          .thenThrow(ServerException());

      // act
      final result = await repository.searchTvSeries(dummyQuery);

      // assert
      verify(mockTvSeriesRemoteDataSource.searchTvSeries(dummyQuery));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvSeriesRemoteDataSource.searchTvSeries(dummyQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result = await repository.searchTvSeries(dummyQuery);

      // assert
      verify(mockTvSeriesRemoteDataSource.searchTvSeries(dummyQuery));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get watchlist tv series', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.getWatchlist())
          .thenAnswer((_) async => [dummyTvSeriesTable]);

      // act
      final result = await repository.getWatchlistTvSeries();

      // assert
      final resultList = result.getOrElse(() => [tvSeriesFromDb]);
      expect(resultList, [tvSeriesFromDb]);
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.getTvSeriesById(dummyId))
          .thenAnswer((_) async => null);

      // act
      final result = await repository.isAddedToWatchlistTvSeries(dummyId);

      // assert
      expect(result, false);
    });

    test('should return watch status whether data is not found found',
        () async {
      // arrange
      when(mockTvSeriesLocalDataSource.getTvSeriesById(dummyId))
          .thenAnswer((_) async => dummyTvSeriesTable);

      // act
      final result = await repository.isAddedToWatchlistTvSeries(dummyId);

      // assert
      expect(result, true);
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource
              .insertWatchlist(dummyTvSeriesTable.toJson()))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result =
          await repository.saveWatchlistTvSeries(dummyTvSeriesTable.toJson());

      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource
              .insertWatchlist(dummyTvSeriesTable.toJson()))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result =
          await repository.saveWatchlistTvSeries(dummyTvSeriesTable.toJson());

      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.removeWatchlist(dummyTvSeriesTable.id))
          .thenAnswer((_) async => 'Removed from watchlist');

      // act
      final result =
          await repository.removeWatchlistTvSeries(dummyTvSeriesTable.id);

      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvSeriesLocalDataSource.removeWatchlist(dummyTvSeriesTable.id))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      // act
      final result =
          await repository.removeWatchlistTvSeries(dummyTvSeriesTable.id);

      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
}
