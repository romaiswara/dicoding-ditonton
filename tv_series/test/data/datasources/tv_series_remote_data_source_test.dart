import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  final List<TvSeries> dummyTvSeriesList = [tvSeriesTest];
  final List<TvSeries> dummyTvSeriesSearchList = [tvSeriesSearchTest];
  const int dummyId = 31910;
  const TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;
  final List<TvSeries> dummyTvSeriesRecommendationsList = [
    tvSeriesRecommendationTest
  ];
  const String dummyQuery = 'naruto';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get airing today tv series', () {
    test('should return list of tv series when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series.json'), 200));
      // act
      final result = await dataSource.getAiringTodayTvSeries();
      // assert
      expect(result.map((e) => e.toEntity()).toList(), dummyTvSeriesList);
    });
    test(
      'should throw a ServerException when when the response code is 400',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 400));
        // act
        final call = await dataSource.getAiringTodayTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
      skip: true,
    );
  });

  group('get on the air tv series', () {
    test('should return list of tv series when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series.json'), 200));
      // act
      final result = await dataSource.getOnTheAirTvSeries();
      // assert
      expect(result.map((e) => e.toEntity()).toList(), dummyTvSeriesList);
    });
    test(
      'should throw a ServerException when when the response code is 400',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 400));
        // act
        final call = await dataSource.getOnTheAirTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
      skip: true,
    );
  });

  group('get popular tv series', () {
    test('should return list of tv series when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series.json'), 200));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result.map((e) => e.toEntity()).toList(), dummyTvSeriesList);
    });
    test(
      'should throw a ServerException when when the response code is 400',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 400));
        // act
        final call = await dataSource.getPopularTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
      skip: true,
    );
  });

  group('get top rated tv series', () {
    test('should return list of tv series when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result.map((e) => e.toEntity()).toList(), dummyTvSeriesList);
    });
    test(
      'should throw a ServerException when when the response code is 400',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 400));
        // act
        final call = await dataSource.getTopRatedTvSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
      skip: true,
    );
  });

  group('get tv series detail', () {
    test('should return detail of tv series when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$dummyId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series_detail.json'), 200));
      // act
      final result = await dataSource.getTvSeriesDetail(dummyId);
      // assert
      expect(result.toEntity(), dummyTvSeriesDetail);
    });
    test(
      'should throw a ServerException when when the response code is 400',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$dummyId?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 400));
        // act
        final call = await dataSource.getTvSeriesDetail(dummyId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
      skip: true,
    );
  });

  group('get recommendations tv series', () {
    test('should return list of tv series when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$dummyId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvSeriesRecommendations(dummyId);
      // assert
      expect(result.map((e) => e.toEntity()).toList(),
          dummyTvSeriesRecommendationsList);
    });
    test(
      'should throw a ServerException when when the response code is 400',
      () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$baseUrl/tv/$dummyId/recommendations?$apiKey')))
            .thenAnswer((_) async => http.Response('Not Found', 400));
        // act
        final call = await dataSource.getTvSeriesRecommendations(dummyId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
      skip: true,
    );
  });

  group('get search tv series', () {
    test('should return list of tv series when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$dummyQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_naruto_tv_series.json'), 200));
      // act
      final result = await dataSource.searchTvSeries(dummyQuery);
      // assert
      expect(result.map((e) => e.toEntity()).toList(), dummyTvSeriesSearchList);
    });
    test(
      'should throw a ServerException when when the response code is 400',
      () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$dummyQuery')))
            .thenAnswer((_) async => http.Response('Not Found', 400));
        // act
        final call = await dataSource.searchTvSeries(dummyQuery);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
        // expect(() => call, isInstanceOf<ServerException>());
      },
      skip: true,
    );
  });
}
