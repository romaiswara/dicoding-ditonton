import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  const TvSeriesTable dummyTvSeriesTable = tvSeriesTableTest;

  test('should save tv series to the repository', () async {
    // arrange
    when(mockTvSeriesRepository
            .saveWatchlistTvSeries(dummyTvSeriesTable.toJson()))
        .thenAnswer((_) async => Right('Added to Watchlist'));

    // act
    final result = await usecase.execute(dummyTvSeriesTable.toJson());

    // assert
    expect(result, Right('Added to Watchlist'));
  });
}
