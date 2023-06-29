import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesCubit cubit;
  late MockGetPopularMovies mockGetPopularMovies;

  final Movie dummyMovie = testMovie;
  final List<Movie> dummyMovieList = [dummyMovie];

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    cubit = PopularMoviesCubit(
      getPopularMovies: mockGetPopularMovies,
    );
  });

  tearDown(() => cubit.close());

  blocTest<PopularMoviesCubit, BaseState<List<Movie>>>(
    'Should emit LoadingState & LoadedState when data is gotten successfully with has data',
    build: () => cubit,
    act: (cubit) {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(dummyMovieList));

      return cubit.get();
    },
    expect: () => [
      const LoadingState<List<Movie>>(),
      LoadedState(data: dummyMovieList),
    ],
  );

  blocTest<PopularMoviesCubit, BaseState<List<Movie>>>(
    'Should emit LoadingState & EmptyState when data is gotten successfully but no data',
    build: () => cubit,
    act: (cubit) {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));

      return cubit.get();
    },
    expect: () => [
      const LoadingState<List<Movie>>(),
      const EmptyState<List<Movie>>(),
    ],
  );

  blocTest<PopularMoviesCubit, BaseState<List<Movie>>>(
    'Should emit LoadingState & ErrorState when data is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return cubit.get();
    },
    expect: () => [
      const LoadingState<List<Movie>>(),
      const ErrorState<List<Movie>>(message: 'Server Failure'),
    ],
  );
}
