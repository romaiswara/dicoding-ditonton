import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvSeriesTable({
    required this.id,
    this.name,
    this.posterPath,
    this.overview,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) {
    return TvSeriesTable(
      id: tvSeries.id,
      name: tvSeries.name,
      posterPath: tvSeries.posterPath,
      overview: tvSeries.overview,
    );
  }

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) {
    return TvSeriesTable(
      id: map['id'],
      name: map['name'],
      posterPath: map['poster_path'],
      overview: map['overview'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'overview': overview,
    };
  }

  TvSeries toEntity() {
    return TvSeries(
      id: id,
      name: name,
      posterPath: posterPath,
      overview: overview,
    );
  }

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
