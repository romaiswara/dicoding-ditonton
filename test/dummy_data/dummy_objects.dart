import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'poster_path': 'posterPath',
  'title': 'title',
};

/// tv series
final TvSeries tvSeriesTest = TvSeries(
  backdropPath: '/a6ptrTUH1c5OdWanjyYtAkOuYD0.jpg',
  firstAirDate: '1999-10-20',
  genreIds: [16],
  id: 37854,
  name: 'One Piece',
  originCountry: ['JP'],
  originalLanguage: 'ja',
  originalName: 'One Piece',
  overview: 'Overview!',
  posterPath: '/dum1wnm6kJOUos0XJqjB8s2UWi9.jpg',
  voteAverage: 8.7,
  voteCount: 3790,
);

final TvSeries tvSeriesRecommendationTest = TvSeries(
  backdropPath: '/xuJ0F9RfKvVSJNDg2usurQ9WvY5.jpg',
  firstAirDate: '2002-10-03',
  genreIds: [16],
  id: 46260,
  name: 'Naruto',
  originCountry: ['JP'],
  originalLanguage: 'ja',
  originalName: 'Naruto',
  overview: 'Overview!',
  posterPath: '/xppeysfvDKVx775MFuH8Z9BlpMk.jpg',
  voteAverage: 8.4,
  voteCount: 5091,
);

final TvSeries tvSeriesSearchTest = TvSeries(
  backdropPath: '/xuJ0F9RfKvVSJNDg2usurQ9WvY5.jpg',
  firstAirDate: '2002-10-03',
  genreIds: [16],
  id: 46260,
  name: 'Naruto',
  originCountry: ['JP'],
  originalLanguage: 'ja',
  originalName: 'Naruto',
  overview: 'Overview!',
  posterPath: '/xppeysfvDKVx775MFuH8Z9BlpMk.jpg',
  voteAverage: 8.4,
  voteCount: 5091,
);

final TvSeriesDetail tvSeriesDetailTest = TvSeriesDetail(
  adult: false,
  backdropPath: '/z0YhJvomqedHF85bplUJEotkN5l.jpg',
  firstAirDate: '2007-02-15',
  genres: [Genre(id: 16, name: 'Animation')],
  id: 31910,
  lastAirDate: '2017-03-23',
  lastEpisodeToAir: Episode(
    id: 1404128,
    name:
        'Hidden Leaf Story, The Perfect Day for a Wedding, Part 7: The Message',
    overview: 'Overview!',
    voteAverage: 6.5,
    voteCount: 6,
    airDate: '2017-03-23',
    episodeNumber: 500,
    productionCode: '',
    runtime: 25,
    seasonNumber: 20,
    stillPath: '/1swhNPNh16f1B6ZqEAmCg7mkWSn.jpg',
  ),
  name: 'Naruto Shippuden',
  nextEpisodeToAir: null,
  numberOfEpisodes: 500,
  numberOfSeasons: 20,
  originalName: 'Naruto Shippuden',
  overview: 'Overview!',
  posterPath: '/zAYRe2bJxpWTVrwwmBc00VFkAf4.jpg',
  seasons: [
    Season(
      airDate: '2007-02-15',
      episodeCount: 32,
      id: 43373,
      name: 'Kazekage Rescue',
      overview: 'Overview!',
      posterPath: '/xSMgujXu00no2m1CCaMr4e6tARZ.jpg',
      seasonNumber: 1,
    ),
  ],
  voteAverage: 8.556,
  voteCount: 7586,
);

final TvSeriesTable tvSeriesTableTest = TvSeriesTable(
  id: 1,
  name: 'Naruto',
  posterPath: 'posterPath',
  overview: 'Overview',
);

final Map<String, dynamic> tvSeriesTableTestMap = {
  'id': 1,
  'name': 'Naruto',
  'poster_path': 'posterPath',
  'overview': 'Overview',
};
