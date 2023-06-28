import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/domain.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;
  final GetOnTheAirTvSeries getOnTheAirTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListNotifier({
    required this.getAiringTodayTvSeries,
    required this.getOnTheAirTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  /// airing today
  List<TvSeries> _airingTodayTvSeries = <TvSeries>[];
  RequestState _airingTodayState = RequestState.Empty;

  /// on the air
  List<TvSeries> _onTheAirTvSeries = <TvSeries>[];
  RequestState _onTheAirState = RequestState.Empty;

  /// popular
  List<TvSeries> _popularTvSeries = <TvSeries>[];
  RequestState _popularState = RequestState.Empty;

  /// top rated
  List<TvSeries> _topRatedTvSeries = <TvSeries>[];
  RequestState _topRatedState = RequestState.Empty;
  String _message = '';

  List<TvSeries> get airingTodayTvSeries => _airingTodayTvSeries;

  RequestState get airingTodayState => _airingTodayState;

  List<TvSeries> get onTheAirTvSeries => _onTheAirTvSeries;

  RequestState get onTheAirState => _onTheAirState;

  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState get popularState => _popularState;

  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState get topRatedState => _topRatedState;

  String get message => _message;

  Future<void> fetchAiringTodayTvSeries() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvSeries.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchOnTheAirTvSeries() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTvSeries.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _onTheAirState = RequestState.Loaded;
        _onTheAirTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularState = RequestState.Loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
