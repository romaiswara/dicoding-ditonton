import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final dummyTvSeries = tvSeriesTest;
  final dummyTvSeriesSearch = tvSeriesSearchTest;
  final dummyTvSeriesRecommendationTest = tvSeriesRecommendationTest;

  final dummyTvSeriesMap = {
    'backdrop_path': '/a6ptrTUH1c5OdWanjyYtAkOuYD0.jpg',
    'first_air_date': '1999-10-20',
    'genre_ids': [16],
    'id': 37854,
    'name': 'One Piece',
    'origin_country': ['JP'],
    'original_language': 'ja',
    'original_name': 'One Piece',
    'overview': 'Overview!',
    'poster_path': '/dum1wnm6kJOUos0XJqjB8s2UWi9.jpg',
    'vote_average': 8.7,
    'vote_count': 3790,
  };

  test('should return a valid model from tv_series.json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series.json'));

    // act
    final result = (jsonMap['results'] as List)
        .map((e) => TvSeriesModel.fromJson(e))
        .first;

    // assert
    expect(result.toEntity(), dummyTvSeries);
  });

  test('should return a valid model from search_naruto_tv_series.json',
      () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/search_naruto_tv_series.json'));

    // act
    final result = (jsonMap['results'] as List)
        .map((e) => TvSeriesModel.fromJson(e))
        .first;

    // assert
    expect(result.toEntity(), dummyTvSeriesSearch);
  });

  test('should return a valid model from tv_series_recommendations.json',
      () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series_recommendations.json'));

    // act
    final result = (jsonMap['results'] as List)
        .map((e) => TvSeriesModel.fromJson(e))
        .first;

    // assert
    expect(result.toEntity(), dummyTvSeriesRecommendationTest);
  });

  test('should return map when call toJson()', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series.json'));

    // act
    final result = (jsonMap['results'] as List)
        .map((e) => TvSeriesModel.fromJson(e))
        .first
        .toJson();

    // assert
    expect(result, dummyTvSeriesMap);
  });
}
