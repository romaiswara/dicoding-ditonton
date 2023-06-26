import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final dummyTvSeries = tvSeriesTest;
  final dummyTvSeriesSearch = tvSeriesSearchTest;
  final dummyTvSeriesRecommendationTest = tvSeriesRecommendationTest;

  test('should return a valid model from tv_series.json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series.json'));

    // act
    final result = (jsonMap['results'] as List)
        .map((e) => TvSeriesModel.fromJson(e))
        .first;

    // assert
    expect(dummyTvSeries, result.toEntity());
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
    expect(dummyTvSeriesSearch, result.toEntity());
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
    expect(dummyTvSeriesRecommendationTest, result.toEntity());
  });
}
