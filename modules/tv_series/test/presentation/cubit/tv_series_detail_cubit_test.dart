import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail, GetTvSeriesRecommendations])
void main() {
  late TvSeriesDetailCubit cubit;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  const int dummyId = 31910;
  const TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;
  const TvSeries dummyTvSeriesRecommendation = tvSeriesRecommendationTest;
  final List<TvSeries> dummyTvSeriesRecommendationList = [
    dummyTvSeriesRecommendation
  ];

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    cubit = TvSeriesDetailCubit(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
    );
  });

  tearDown(() => cubit.close());

  blocTest<TvSeriesDetailCubit, BaseState<TvSeriesDetail>>(
    'Should emit LoadingState & LoadedState when data is gotten successfully',
    build: () => cubit,
    act: (cubit) {
      when(mockGetTvSeriesDetail.execute(dummyId))
          .thenAnswer((_) async => const Right(dummyTvSeriesDetail));

      when(mockGetTvSeriesRecommendations.execute(dummyId))
          .thenAnswer((_) async => Right(dummyTvSeriesRecommendationList));

      return cubit.get(id: dummyId);
    },
    expect: () => [
      const LoadingState<TvSeriesDetail>(),
      LoadedState(
        data: dummyTvSeriesDetail.updateRecommendations(
          recommendations: dummyTvSeriesRecommendationList,
        ),
      ),
    ],
  );

  blocTest<TvSeriesDetailCubit, BaseState<TvSeriesDetail>>(
    'Should emit LoadingState & ErrorState when get detail is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockGetTvSeriesDetail.execute(dummyId))
          .thenAnswer((_) async => const Right(dummyTvSeriesDetail));

      when(mockGetTvSeriesRecommendations.execute(dummyId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return cubit.get(id: dummyId);
    },
    expect: () => [
      const LoadingState<TvSeriesDetail>(),
      const ErrorState<TvSeriesDetail>(message: 'Server Failure'),
    ],
  );

  blocTest<TvSeriesDetailCubit, BaseState<TvSeriesDetail>>(
    'Should emit LoadingState & ErrorState when get recommendation is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockGetTvSeriesDetail.execute(dummyId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetTvSeriesRecommendations.execute(dummyId))
          .thenAnswer((_) async => Right(dummyTvSeriesRecommendationList));

      return cubit.get(id: dummyId);
    },
    expect: () => [
      const LoadingState<TvSeriesDetail>(),
      const ErrorState<TvSeriesDetail>(message: 'Server Failure'),
    ],
  );
}
