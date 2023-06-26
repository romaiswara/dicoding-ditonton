import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final int dummyId = 31910;
  final TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;

  test('should get detail of tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(dummyId))
        .thenAnswer((_) async => Right(dummyTvSeriesDetail));

    // act
    final result = await usecase.execute(dummyId);

    // assert
    expect(result, Right(dummyTvSeriesDetail));
  });
}
