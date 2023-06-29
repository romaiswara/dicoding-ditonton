import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/domain.dart';

class GetOnTheAirTvSeries {
  final TvSeriesRepository repository;

  GetOnTheAirTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getOnTheAirTvSeries();
  }
}
