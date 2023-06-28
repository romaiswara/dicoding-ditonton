import 'package:core/core.dart';
import 'package:tv_series/data/data.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();

  Future<List<TvSeriesModel>> getOnTheAirTvSeries();

  Future<List<TvSeriesModel>> getPopularTvSeries();

  Future<List<TvSeriesModel>> getTopRatedTvSeries();

  Future<List<TvSeriesModel>> searchTvSeries(String query);

  Future<TvSeriesDetailModel> getTvSeriesDetail(int id);

  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final DioClient client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries() async {
    final response = await client.get(url: '/tv/airing_today');

    if (response.statusCode == 200) {
      final data = response.data;
      return (data['results'] as List)
          .map((e) => TvSeriesModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getOnTheAirTvSeries() async {
    final response = await client.get(url: '/tv/on_the_air');

    if (response.statusCode == 200) {
      final data = response.data;
      return (data['results'] as List)
          .map((e) => TvSeriesModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(url: '/tv/popular');

    if (response.statusCode == 200) {
      final data = response.data;
      return (data['results'] as List)
          .map((e) => TvSeriesModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(url: '/tv/top_rated');

    if (response.statusCode == 200) {
      final data = response.data;
      return (data['results'] as List)
          .map((e) => TvSeriesModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id) async {
    final response = await client.get(url: '/tv/$id');

    if (response.statusCode == 200) {
      final data = response.data;
      return TvSeriesDetailModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id) async {
    final response = await client.get(url: '/tv/$id/recommendations');

    if (response.statusCode == 200) {
      final data = response.data;
      return (data['results'] as List)
          .map((e) => TvSeriesModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(url: '/search/tv', query: query);

    if (response.statusCode == 200) {
      final data = response.data;
      return (data['results'] as List)
          .map((e) => TvSeriesModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
