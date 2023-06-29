import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/domain.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);

  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);

  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  Future<Either<Failure, String>> saveWatchlistMovie(Map<String, dynamic> data);

  Future<Either<Failure, String>> removeWatchlistMovie(int movieId);

  Future<bool> isAddedToWatchlistMovie(int id);

  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
