import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/cubit/base_state.dart';

class TvSeriesSearchCubit extends Cubit<BaseState<List<TvSeries>>> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchCubit({required this.searchTvSeries})
      : super(const InitializedState());

  void get({required String query}) async {
    emit(const LoadingState());
    final result = await searchTvSeries.execute(query);

    BaseState<List<TvSeries>> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (tvSeriesData) => tvSeriesData.isEmpty
          ? const EmptyState()
          : LoadedState(data: tvSeriesData),
    );

    emit(resultState);
  }
}
