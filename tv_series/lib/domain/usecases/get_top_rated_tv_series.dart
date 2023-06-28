import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/domain.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
