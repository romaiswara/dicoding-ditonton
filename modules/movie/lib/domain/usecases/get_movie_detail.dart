import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/domain.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
