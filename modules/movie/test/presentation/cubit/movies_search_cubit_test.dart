import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movies_search_cubit_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchCubit cubit;
  late MockSearchMovies mockSearchMovies;

  const String dummyQuery = 'spider';
  final Movie dummyMovie = testMovie;
  final List<Movie> dummyMovieList = [dummyMovie];

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    cubit = MovieSearchCubit(
      searchMovies: mockSearchMovies,
    );
  });

  tearDown(() => cubit.close());

  blocTest<MovieSearchCubit, BaseState<List<Movie>>>(
    'Should emit LoadingState & LoadedState when data is gotten successfully with has data',
    build: () => cubit,
    act: (cubit) {
      when(mockSearchMovies.execute(dummyQuery))
          .thenAnswer((_) async => Right(dummyMovieList));

      return cubit.get(query: dummyQuery);
    },
    expect: () => [
      const LoadingState<List<Movie>>(),
      LoadedState(data: dummyMovieList),
    ],
  );

  blocTest<MovieSearchCubit, BaseState<List<Movie>>>(
    'Should emit LoadingState & EmptyState when data is gotten successfully but no data',
    build: () => cubit,
    act: (cubit) {
      when(mockSearchMovies.execute(dummyQuery))
          .thenAnswer((_) async => const Right([]));

      return cubit.get(query: dummyQuery);
    },
    expect: () => [
      const LoadingState<List<Movie>>(),
      const EmptyState<List<Movie>>(),
    ],
  );

  blocTest<MovieSearchCubit, BaseState<List<Movie>>>(
    'Should emit LoadingState & ErrorState when data is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockSearchMovies.execute(dummyQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return cubit.get(query: dummyQuery);
    },
    expect: () => [
      const LoadingState<List<Movie>>(),
      const ErrorState<List<Movie>>(message: 'Server Failure'),
    ],
  );
}
