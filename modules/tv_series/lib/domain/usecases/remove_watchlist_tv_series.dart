import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/domain.dart';

class RemoveWatchlistTvSeries {
  final TvSeriesRepository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(int tvSeriesId) {
    return repository.removeWatchlistTvSeries(tvSeriesId);
  }
}
