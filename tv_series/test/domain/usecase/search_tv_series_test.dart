import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  const String dummyQuery = 'naruto';
  final List<TvSeries> dummyTvSeries = [tvSeriesSearchTest];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(dummyQuery))
        .thenAnswer((_) async => Right(dummyTvSeries));

    // act
    final result = await usecase.execute(dummyQuery);

    // assert
    expect(result, Right(dummyTvSeries));
  });
}
