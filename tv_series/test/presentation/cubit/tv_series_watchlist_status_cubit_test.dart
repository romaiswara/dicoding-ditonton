import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_status_cubit_test.mocks.dart';

@GenerateMocks([GetWatchListTvSeriesStatus])
void main() {
  late TvSeriesWatchlistStatusCubit cubit;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;

  const int dummyId = 37854;
  const TvSeries dummyTvSeries = tvSeriesTest;

  setUp(() {
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    cubit = TvSeriesWatchlistStatusCubit(
      getWatchListTvSeriesStatus: mockGetWatchListTvSeriesStatus,
    );
  });

  tearDown(() => cubit.close());

  blocTest<TvSeriesWatchlistStatusCubit, bool>(
    'Should emit false when data is not available on watchlist',
    build: () => cubit,
    act: (cubit) {
      when(mockGetWatchListTvSeriesStatus.execute(dummyId))
          .thenAnswer((_) async => false);

      return cubit.get(id: dummyId);
    },
    expect: () => [
      false,
    ],
  );

  blocTest<TvSeriesWatchlistStatusCubit, bool>(
    'Should emit true when data is available on watchlist',
    build: () => cubit,
    act: (cubit) {
      when(mockGetWatchListTvSeriesStatus.execute(dummyId))
          .thenAnswer((_) async => true);

      return cubit.get(id: dummyId);
    },
    expect: () => [
      true,
    ],
  );
}
