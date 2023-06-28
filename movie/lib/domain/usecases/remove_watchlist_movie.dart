import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/domain.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(int movieId) {
    return repository.removeWatchlistMovie(movieId);
  }
}
