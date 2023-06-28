import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  const int dummyId = 31910;
  final List<TvSeries> dummyTvSeries = [tvSeriesRecommendationTest];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesRecommendations(dummyId))
        .thenAnswer((_) async => Right(dummyTvSeries));

    // act
    final result = await usecase.execute(dummyId);

    // assert
    expect(result, Right(dummyTvSeries));
  });
}
