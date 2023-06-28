import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/domain.dart';

class TvSeriesDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<Genre>? genres;
  final int id;
  final String? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String? name;
  final Episode? nextEpisodeToAir;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final List<Season>? seasons;
  final double? voteAverage;
  final int? voteCount;
  final List<TvSeries>? recommendations;

  const TvSeriesDetail({
    this.adult,
    this.backdropPath,
    this.firstAirDate,
    this.genres,
    required this.id,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originalName,
    this.overview,
    this.posterPath,
    this.seasons,
    this.voteAverage,
    this.voteCount,
    this.recommendations,
  });

  TvSeriesDetail updateRecommendations({
    required List<TvSeries> recommendations,
  }) {
    return TvSeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genres: genres,
      id: id,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir,
      name: name,
      nextEpisodeToAir: nextEpisodeToAir,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      seasons: seasons,
      voteAverage: voteAverage,
      voteCount: voteCount,
      recommendations: recommendations,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        firstAirDate,
        genres,
        id,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        originalName,
        overview,
        posterPath,
        seasons,
        voteAverage,
        voteCount,
        recommendations,
      ];
}
