import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final List<TvSeries> dummyTvSeries = [tvSeriesTest];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getPopularTvSeries())
        .thenAnswer((_) async => Right(dummyTvSeries));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(dummyTvSeries));
  });
}
