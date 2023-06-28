import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/domain.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesNotifier({required this.getWatchlistTvSeries});

  List<TvSeries> _watchlistTvSeries = <TvSeries>[];

  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
