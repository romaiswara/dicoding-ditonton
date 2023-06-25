import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailModel extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<GenreModel>? genres;
  final int id;
  final String? lastAirDate;
  final EpisodeModel? lastEpisodeToAir;
  final String? name;
  final EpisodeModel? nextEpisodeToAir;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final List<SeasonModel>? seasons;
  final double? voteAverage;
  final int? voteCount;

  TvSeriesDetailModel({
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

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesDetailModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'],
      genres: List<GenreModel>.from(
          json['genres'].map((e) => GenreModel.fromJson(e))),
      id: json['id'],
      lastAirDate: json['last_air_date'],
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? EpisodeModel.fromJson(json['last_episode_to_air'])
          : null,
      name: json['name'],
      nextEpisodeToAir: json['next_episode_to_air'] != null
          ? EpisodeModel.fromJson(json['next_episode_to_air'])
          : null,
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      originalName: json['original_name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      seasons: List<SeasonModel>.from(
          json['seasons'].map((e) => SeasonModel.fromJson(e))),
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genres': genres != null
          ? List<dynamic>.from(genres!.map((e) => e.toJson()))
          : null,
      'id': id,
      'last_air_date': lastAirDate,
      'last_episode_to_air': lastEpisodeToAir?.toJson(),
      'name': name,
      'next_episode_to_air': nextEpisodeToAir?.toJson(),
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'seasons': seasons != null
          ? List<dynamic>.from(seasons!.map((e) => e.toJson()))
          : null,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genres: genres != null ? genres!.map((e) => e.toEntity()).toList() : null,
      id: id,
      lastAirDate: lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir?.toEntity(),
      name: name,
      nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      seasons:
          seasons != null ? seasons!.map((e) => e.toEntity()).toList() : null,
      voteAverage: voteAverage,
      voteCount: voteCount,
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
      ];
}
