import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries])
void main() {
  late AiringTodayTvSeriesCubit cubit;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;

  const TvSeries dummyTvSeries = tvSeriesTest;
  final List<TvSeries> dummyTvSeriesList = [dummyTvSeries];

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    cubit = AiringTodayTvSeriesCubit(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
    );
  });

  tearDown(() => cubit.close());

  blocTest<AiringTodayTvSeriesCubit, BaseState<List<TvSeries>>>(
    'Should emit LoadingState & LoadedState when data is gotten successfully with has data',
    build: () => cubit,
    act: (cubit) {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(dummyTvSeriesList));

      return cubit.get();
    },
    expect: () => [
      const LoadingState<List<TvSeries>>(),
      LoadedState(data: dummyTvSeriesList),
    ],
  );

  blocTest<AiringTodayTvSeriesCubit, BaseState<List<TvSeries>>>(
    'Should emit LoadingState & EmptyState when data is gotten successfully but no data',
    build: () => cubit,
    act: (cubit) {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => const Right([]));

      return cubit.get();
    },
    expect: () => [
      const LoadingState<List<TvSeries>>(),
      const EmptyState<List<TvSeries>>(),
    ],
  );

  blocTest<AiringTodayTvSeriesCubit, BaseState<List<TvSeries>>>(
    'Should emit LoadingState & ErrorState when data is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return cubit.get();
    },
    expect: () => [
      const LoadingState<List<TvSeries>>(),
      const ErrorState<List<TvSeries>>(message: 'Server Failure'),
    ],
  );
}
