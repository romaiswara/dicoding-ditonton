import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });

  final TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;

  test('should save tv series to the repository', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlistTvSeries(dummyTvSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));

    // act
    final result = await usecase.execute(dummyTvSeriesDetail);

    // assert
    expect(result, Right('Added to Watchlist'));
  });
}
