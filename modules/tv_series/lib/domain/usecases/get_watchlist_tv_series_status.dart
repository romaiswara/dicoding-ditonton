import 'package:tv_series/domain/domain.dart';

class GetWatchListTvSeriesStatus {
  final TvSeriesRepository repository;

  GetWatchListTvSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvSeries(id);
  }
}
