import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/domain.dart';

class SaveWatchlistTvSeries {
  final TvSeriesRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(Map<String, dynamic> data) {
    return repository.saveWatchlistTvSeries(data);
  }
}
