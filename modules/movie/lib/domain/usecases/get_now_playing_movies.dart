import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/domain.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
