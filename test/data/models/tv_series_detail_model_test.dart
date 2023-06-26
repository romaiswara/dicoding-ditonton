import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final dummyTvSeriesDetailEntity = tvSeriesDetailTest;

  final dummyTvSeriesDetailModel = TvSeriesDetailModel(
    adult: false,
    backdropPath: '/z0YhJvomqedHF85bplUJEotkN5l.jpg',
    firstAirDate: '2007-02-15',
    genres: [GenreModel(id: 16, name: 'Animation')],
    id: 31910,
    lastAirDate: '2017-03-23',
    lastEpisodeToAir: EpisodeModel(
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
      SeasonModel(
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

  final dummyTvSeriesDetailMap = {
    'adult': false,
    'backdrop_path': '/z0YhJvomqedHF85bplUJEotkN5l.jpg',
    'first_air_date': '2007-02-15',
    'genres': [
      {
        'id': 16,
        'name': 'Animation',
      },
    ],
    'id': 31910,
    'last_air_date': '2017-03-23',
    'last_episode_to_air': {
      'id': 1404128,
      'name':
          'Hidden Leaf Story, The Perfect Day for a Wedding, Part 7: The Message',
      'overview': 'Overview!',
      'vote_average': 6.5,
      'vote_count': 6,
      'air_date': '2017-03-23',
      'episode_number': 500,
      'production_code': '',
      'season_number': 20,
      'runtime': 25,
      'still_path': '/1swhNPNh16f1B6ZqEAmCg7mkWSn.jpg'
    },
    'name': 'Naruto Shippuden',
    'next_episode_to_air': null,
    'number_of_episodes': 500,
    'number_of_seasons': 20,
    'original_name': 'Naruto Shippuden',
    'overview': 'Overview!',
    'poster_path': '/zAYRe2bJxpWTVrwwmBc00VFkAf4.jpg',
    'seasons': [
      {
        'air_date': '2007-02-15',
        'episode_count': 32,
        'id': 43373,
        'name': 'Kazekage Rescue',
        'overview': 'Overview!',
        'poster_path': '/xSMgujXu00no2m1CCaMr4e6tARZ.jpg',
        'season_number': 1
      },
    ],
    'vote_average': 8.556,
    'vote_count': 7586,
  };

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series_detail.json'));

    // act
    final result = TvSeriesDetailModel.fromJson(jsonMap);

    // assert
    expect(result.toEntity(), dummyTvSeriesDetailEntity);
  });

  test('should return a valid model from dummyTvSeriesDetailMap', () async {
    // act
    final result = TvSeriesDetailModel.fromJson(dummyTvSeriesDetailMap);

    // assert
    expect(result, dummyTvSeriesDetailModel);
  });

  test('should return map when call toJson()', () async {
    // act
    final result = dummyTvSeriesDetailModel.toJson();

    // assert
    expect(result, dummyTvSeriesDetailMap);
  });
}
