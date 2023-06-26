import 'dart:convert';

import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final dummyTvSeriesDetail = tvSeriesDetailTest;

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_series_detail.json'));

    // act
    final result =  TvSeriesDetailModel.fromJson(jsonMap);

    // assert
    expect(dummyTvSeriesDetail, result.toEntity());
  });
}
