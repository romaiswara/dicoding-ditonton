import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  const int dummyId = 31910;
  const TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;

  test('should get detail of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(dummyId))
        .thenAnswer((_) async => const Right(dummyTvSeriesDetail));

    // act
    final result = await usecase.execute(dummyId);

    // assert
    expect(result, const Right(dummyTvSeriesDetail));
  });
}
