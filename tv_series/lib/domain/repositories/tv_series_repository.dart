import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/domain.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeries();

  Future<Either<Failure, List<TvSeries>>> getOnTheAirTvSeries();

  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();

  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();

  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);

  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);

  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);

  Future<Either<Failure, String>> saveWatchlistTvSeries(
      Map<String, dynamic> data);

  Future<Either<Failure, String>> removeWatchlistTvSeries(int tvSeriesId);

  Future<bool> isAddedToWatchlistTvSeries(int id);

  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
