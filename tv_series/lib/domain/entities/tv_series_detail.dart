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
  });

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
      ];
}
