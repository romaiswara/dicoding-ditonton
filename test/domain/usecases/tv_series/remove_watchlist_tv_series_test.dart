import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  final TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;

  test('should remove watchlist from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlistTvSeries(dummyTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from Watchlist'));

    // act
    final result = await usecase.execute(dummyTvSeriesDetail);

    // assert
    expect(result, Right('Removed from Watchlist'));
  });
}
