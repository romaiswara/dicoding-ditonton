import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  const int dummyId = 1;
  const TvSeriesTable dummyTvSeries = tvSeriesTableTest;
  final Map<String, dynamic> dummyMap = tvSeriesTableTestMap;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(dummyTvSeries.toJson()))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(dummyTvSeries.toJson());
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(dummyTvSeries.toJson()))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(dummyTvSeries.toJson());
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(dummyTvSeries.id))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(dummyTvSeries.id);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(dummyTvSeries.id))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(dummyTvSeries.id);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get watchlist', () {
    test('should return list of tvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [dummyMap]);
      // act
      final result = await dataSource.getWatchlist();
      // assert
      expect(result, [dummyTvSeries]);
    });
  });

  group('get tv series by id', () {
    test('should return tvSeriesTable from database when data is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(dummyId))
          .thenAnswer((_) async => dummyMap);
      // act
      final result = await dataSource.getTvSeriesById(dummyId);
      // assert
      expect(result, dummyTvSeries);
    });

    test('should return null from database when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(dummyId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(dummyId);
      // assert
      expect(result, null);
    });
  });
}
