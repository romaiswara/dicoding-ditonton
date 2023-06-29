import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_status_cubit_test.mocks.dart';

@GenerateMocks([GetWatchListStatus])
void main() {
  late MovieWatchlistStatusCubit cubit;
  late MockGetWatchListStatus mockGetWatchListStatus;

  const int dummyId = 1;
  final Movie dummyMovie = testMovie;
  final List<Movie> dummyMovieList = [dummyMovie];

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    cubit = MovieWatchlistStatusCubit(
      getWatchListStatus: mockGetWatchListStatus,
    );
  });

  tearDown(() => cubit.close());

  blocTest<MovieWatchlistStatusCubit, bool>(
    'Should emit false when data is not available on watchlist',
    build: () => cubit,
    act: (cubit) {
      when(mockGetWatchListStatus.execute(dummyId))
          .thenAnswer((_) async => false);

      return cubit.get(id: dummyId);
    },
    expect: () => [
      false,
    ],
  );

  blocTest<MovieWatchlistStatusCubit, bool>(
    'Should emit true when data is available on watchlist',
    build: () => cubit,
    act: (cubit) {
      when(mockGetWatchListStatus.execute(dummyId))
          .thenAnswer((_) async => true);

      return cubit.get(id: dummyId);
    },
    expect: () => [
      true,
    ],
  );
}
