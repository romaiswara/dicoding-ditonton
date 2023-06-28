import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/data/data.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/cubit/base_state.dart';

class TvSeriesWatchlistActionCubit extends Cubit<BaseState<String>> {
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesWatchlistActionCubit({
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  }) : super(const InitializedState());

  void add({required TvSeriesDetail detail}) async {
    emit(const LoadingState());

    // convert to table
    TvSeriesTable tvSeriesTable = TvSeriesTable.fromEntity(detail);
    final result = await saveWatchlistTvSeries.execute(tvSeriesTable.toJson());

    BaseState<String> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (success) => SuccessState(data: success),
    );

    emit(resultState);
  }

  void remove({required int id}) async {
    emit(const LoadingState());

    final result = await removeWatchlistTvSeries.execute(id);

    BaseState<String> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (success) => SuccessState(data: success),
    );

    emit(resultState);
  }
}
