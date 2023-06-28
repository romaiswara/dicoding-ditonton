import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/domain.dart';

class SaveWatchlistMovie {
  final MovieRepository repository;

  SaveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(Map<String, dynamic> data) {
    return repository.saveWatchlistMovie(data);
  }
}
