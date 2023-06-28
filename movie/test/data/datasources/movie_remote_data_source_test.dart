import 'dart:convert';

import 'package:core/core.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockDioClient);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/now_playing')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: jsonDecode(readJson('dummy_data/now_playing.json')),
          statusCode: 200,
        ),
      );
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/now_playing')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: 'Not Found',
          statusCode: 400,
        ),
      );
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/popular')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: jsonDecode(readJson('dummy_data/popular.json')),
          statusCode: 200,
        ),
      );
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/popular')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: 'Not Found',
          statusCode: 400,
        ),
      );
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockDioClient.get(url: '/movie/top_rated')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: jsonDecode(readJson('dummy_data/top_rated.json')),
          statusCode: 200,
        ),
      );
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/top_rated')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: 'Not Found',
          statusCode: 400,
        ),
      );
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockDioClient.get(url: '/movie/$tId')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: jsonDecode(readJson('dummy_data/movie_detail.json')),
          statusCode: 200,
        ),
      );
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/$tId')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: 'Not Found',
          statusCode: 400,
        ),
      );
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/movie_recommendations.json')))
        .movieList;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/$tId/recommendations')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: jsonDecode(readJson('dummy_data/movie_recommendations.json')),
          statusCode: 200,
        ),
      );
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockDioClient.get(url: '/movie/$tId/recommendations')).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: 'Not Found',
          statusCode: 400,
        ),
      );
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(
            json.decode(readJson('dummy_data/search_spiderman_movie.json')))
        .movieList;
    const tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockDioClient.get(url: '/search/movie', query: tQuery)).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: jsonDecode(readJson('dummy_data/search_spiderman_movie.json')),
          statusCode: 200,
        ),
      );
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockDioClient.get(url: '/search/movie', query: tQuery)).thenAnswer(
        (_) async => dio.Response(
          requestOptions: dio.RequestOptions(),
          data: 'Not Found',
          statusCode: 400,
        ),
      );
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
