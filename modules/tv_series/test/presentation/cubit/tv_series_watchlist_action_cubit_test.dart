import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_action_cubit_test.mocks.dart';

@GenerateMocks([SaveWatchlistTvSeries, RemoveWatchlistTvSeries])
void main() {
  late TvSeriesWatchlistActionCubit cubit;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  const int dummyId = 31910;
  const TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;

  setUp(() {
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    cubit = TvSeriesWatchlistActionCubit(
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  tearDown(() => cubit.close());

  blocTest<TvSeriesWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & SuccessState when add data is gotten successfully',
    build: () => cubit,
    act: (cubit) {
      TvSeriesTable tvSeriesTable =
          TvSeriesTable.fromEntity(dummyTvSeriesDetail);
      when(mockSaveWatchlistTvSeries.execute(tvSeriesTable.toJson()))
          .thenAnswer((_) async => const Right('Added to Watchlist'));

      return cubit.add(detail: dummyTvSeriesDetail);
    },
    expect: () => [
      const LoadingState<String>(),
      const SuccessState(data: 'Added to Watchlist'),
    ],
  );

  blocTest<TvSeriesWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & ErrorState when add  data is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      TvSeriesTable tvSeriesTable =
          TvSeriesTable.fromEntity(dummyTvSeriesDetail);
      when(mockSaveWatchlistTvSeries.execute(tvSeriesTable.toJson()))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return cubit.add(detail: dummyTvSeriesDetail);
    },
    expect: () => [
      const LoadingState<String>(),
      const ErrorState<String>(message: 'Server Failure'),
    ],
  );

  blocTest<TvSeriesWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & SuccessState when remove data is gotten successfully',
    build: () => cubit,
    act: (cubit) {
      when(mockRemoveWatchlistTvSeries.execute(dummyId))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));

      return cubit.remove(id: dummyId);
    },
    expect: () => [
      const LoadingState<String>(),
      const SuccessState(data: 'Removed from Watchlist'),
    ],
  );

  blocTest<TvSeriesWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & ErrorState when remove  data is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockRemoveWatchlistTvSeries.execute(dummyId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return cubit.remove(id: dummyId);
    },
    expect: () => [
      const LoadingState<String>(),
      const ErrorState<String>(message: 'Server Failure'),
    ],
  );
}
