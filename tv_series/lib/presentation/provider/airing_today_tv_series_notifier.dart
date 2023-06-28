import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/domain.dart';

class AiringTodayTvSeriesNotifier extends ChangeNotifier {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;

  AiringTodayTvSeriesNotifier(this.getAiringTodayTvSeries);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];

  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';

  String get message => _message;

  Future<void> fetchAiringTodayTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeriesData) {
        _tvSeries = tvSeriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
