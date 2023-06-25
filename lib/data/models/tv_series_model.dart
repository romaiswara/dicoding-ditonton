import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  TvSeriesModel({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    required this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'],
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      id: json['id'],
      name: json['name'],
      originCountry: List<String>.from(json['origin_country'].map((x) => x)),
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genre_ids':
          genreIds != null ? List<dynamic>.from(genreIds!.map((x) => x)) : null,
      'id': id,
      'name': name,
      'origin_country': originCountry != null
          ? List<dynamic>.from(originCountry!.map((x) => x))
          : null,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  TvSeries toEntity() {
    return TvSeries(
      backdropPath: backdropPath,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
      id: id,
      name: name,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
