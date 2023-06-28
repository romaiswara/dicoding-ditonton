import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';

class TvSeriesWatchlistStatusCubit extends Cubit<bool> {
  final GetWatchListTvSeriesStatus getWatchListTvSeriesStatus;

  TvSeriesWatchlistStatusCubit({
    required this.getWatchListTvSeriesStatus,
  }) : super(false);

  void get({required int id}) async {
    final result = await getWatchListTvSeriesStatus.execute(id);
    emit(result);
  }
}
