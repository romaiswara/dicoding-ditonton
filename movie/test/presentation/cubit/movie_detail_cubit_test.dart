import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MovieDetailCubit cubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  const int dummyId = 1;
  const MovieDetail dummyMovieDetail = testMovieDetail;
  final List<Movie> dummyMovieRecommendationList = [testMovie];

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    cubit = MovieDetailCubit(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  tearDown(() => cubit.close());

  blocTest<MovieDetailCubit, BaseState<MovieDetail>>(
    'Should emit LoadingState & LoadedState when data is gotten successfully',
    build: () => cubit,
    act: (cubit) {
      when(mockGetMovieDetail.execute(dummyId))
          .thenAnswer((_) async => const Right(dummyMovieDetail));

      when(mockGetMovieRecommendations.execute(dummyId))
          .thenAnswer((_) async => Right(dummyMovieRecommendationList));

      return cubit.get(id: dummyId);
    },
    expect: () => [
      const LoadingState<MovieDetail>(),
      LoadedState(
        data: dummyMovieDetail.updateRecommendations(
          recommendations: dummyMovieRecommendationList,
        ),
      ),
    ],
  );

  blocTest<MovieDetailCubit, BaseState<MovieDetail>>(
    'Should emit LoadingState & ErrorState when get detail is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockGetMovieDetail.execute(dummyId))
          .thenAnswer((_) async => const Right(dummyMovieDetail));

      when(mockGetMovieRecommendations.execute(dummyId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return cubit.get(id: dummyId);
    },
    expect: () => [
      const LoadingState<MovieDetail>(),
      const ErrorState<MovieDetail>(message: 'Server Failure'),
    ],
  );

  blocTest<MovieDetailCubit, BaseState<MovieDetail>>(
    'Should emit LoadingState & ErrorState when get recommendation is unsuccessful',
    build: () => cubit,
    act: (cubit) {
      when(mockGetMovieDetail.execute(dummyId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      when(mockGetMovieRecommendations.execute(dummyId))
          .thenAnswer((_) async => Right(dummyMovieRecommendationList));

      return cubit.get(id: dummyId);
    },
    expect: () => [
      const LoadingState<MovieDetail>(),
      const ErrorState<MovieDetail>(message: 'Server Failure'),
    ],
  );
}
