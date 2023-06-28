import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  const TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;

  test('should remove watchlist from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlistTvSeries(dummyTvSeriesDetail.id))
        .thenAnswer((_) async => const Right('Removed from Watchlist'));

    // act
    final result = await usecase.execute(dummyTvSeriesDetail.id);

    // assert
    expect(result, const Right('Removed from Watchlist'));
  });
}
