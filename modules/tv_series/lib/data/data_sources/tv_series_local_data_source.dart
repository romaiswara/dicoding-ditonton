import 'package:core/core.dart';
import 'package:tv_series/data/data.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlist(Map<String, dynamic> data);

  Future<String> removeWatchlist(int tvSeriesId);

  Future<TvSeriesTable?> getTvSeriesById(int id);

  Future<List<TvSeriesTable>> getWatchlist();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    try {
      final result = await databaseHelper.getTvSeriesById(id);
      if (result != null) {
        return TvSeriesTable.fromMap(result);
      }
      return null;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlist() async {
    try {
      final result = await databaseHelper.getWatchlistTvSeries();
      return result.map((e) => TvSeriesTable.fromMap(e)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertWatchlist(Map<String, dynamic> data) async {
    try {
      await databaseHelper.insertTvSeriesWatchlist(data);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(int tvSeriesId) async {
    try {
      await databaseHelper.removeTvSeriesWatchlist(tvSeriesId);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
