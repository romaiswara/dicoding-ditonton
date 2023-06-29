import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_action_cubit_test.mocks.dart';

@GenerateMocks([SaveWatchlistMovie, RemoveWatchlistMovie])
void main() {
  late MovieWatchlistActionCubit cubit;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  const int dummyId = 1;
  const MovieDetail dummyMovieDetail = testMovieDetail;

  setUp(() {
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    cubit = MovieWatchlistActionCubit(
      saveWatchlistMovie: mockSaveWatchlistMovie,
      removeWatchlistMovie: mockRemoveWatchlistMovie,
    );
  });

  tearDown(() => cubit.close());

  blocTest<MovieWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & SuccessState when add data is gotten successfully',
    build: () => cubit,
    act: (cubit) {
      MovieTable movieTable = MovieTable.fromEntity(dummyMovieDetail);
      when(mockSaveWatchlistMovie.execute(movieTable.toJson()))
          .thenAnswer((_) async => const Right('Added to Watchlist'));

      return cubit.add(detail: dummyMovieDetail);
    },
    expect: () => [
      const LoadingState<String>(),
      const SuccessState(data: 'Added to Watchlist'),
    ],
  );

  blocTest<MovieWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & ErrorState when add  data is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      MovieTable movieTable = MovieTable.fromEntity(dummyMovieDetail);
      when(mockSaveWatchlistMovie.execute(movieTable.toJson()))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return cubit.add(detail: dummyMovieDetail);
    },
    expect: () => [
      const LoadingState<String>(),
      const ErrorState<String>(message: 'Server Failure'),
    ],
  );

  blocTest<MovieWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & SuccessState when remove data is gotten successfully',
    build: () => cubit,
    act: (cubit) {
      when(mockRemoveWatchlistMovie.execute(dummyId))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));

      return cubit.remove(id: dummyId);
    },
    expect: () => [
      const LoadingState<String>(),
      const SuccessState(data: 'Removed from Watchlist'),
    ],
  );

  blocTest<MovieWatchlistActionCubit, BaseState<String>>(
    'Should emit LoadingState & ErrorState when remove  data is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockRemoveWatchlistMovie.execute(dummyId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return cubit.remove(id: dummyId);
    },
    expect: () => [
      const LoadingState<String>(),
      const ErrorState<String>(message: 'Server Failure'),
    ],
  );
}
