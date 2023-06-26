import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_on_the_air_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetOnTheAirTvSeries(mockTvSeriesRepository);
  });

  final List<TvSeries> dummyTvSeries = [tvSeriesTest];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getOnTheAirTvSeries())
        .thenAnswer((_) async => Right(dummyTvSeries));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(dummyTvSeries));
  });
}
