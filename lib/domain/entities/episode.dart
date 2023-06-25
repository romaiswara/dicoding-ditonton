import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String? name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final String? airDate;
  final int? episodeNumber;
  final String? productionCode;
  final int? seasonNumber;
  final String? stillPath;

  Episode({
    required this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
  });

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
        stillPath,
      ];
}
