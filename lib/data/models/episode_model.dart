import 'package:ditonton/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final int id;
  final String? name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final String? airDate;
  final int? episodeNumber;
  final String? productionCode;
  final int? seasonNumber;

  EpisodeModel({
    required this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.seasonNumber,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      airDate: json['air_date'],
      episodeNumber: json['episode_number'],
      productionCode: json['production_code'],
      seasonNumber: json['season_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'production_code': productionCode,
      'season_number': seasonNumber,
    };
  }

  Episode toEntity() {
    return Episode(
      id: id,
      name: name,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      airDate: airDate,
      episodeNumber: episodeNumber,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        voteAverage,
        voteCount,
        airDate,
        episodeNumber,
        productionCode,
        seasonNumber,
      ];
}
