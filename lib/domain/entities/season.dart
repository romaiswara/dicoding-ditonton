import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  Season({
    this.airDate,
    this.episodeCount,
    required this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
