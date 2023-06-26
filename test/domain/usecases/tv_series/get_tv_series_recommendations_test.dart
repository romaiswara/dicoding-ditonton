import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  final int dummyId = 31910;
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
