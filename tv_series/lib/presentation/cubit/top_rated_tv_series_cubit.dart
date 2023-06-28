import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/cubit/base_state.dart';

class TopRatedTvSeriesCubit extends Cubit<BaseState<List<TvSeries>>> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesCubit({required this.getTopRatedTvSeries})
      : super(const InitializedState());

  void get() async {
    emit(const LoadingState());
    final result = await getTopRatedTvSeries.execute();

    BaseState<List<TvSeries>> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (tvSeriesData) => tvSeriesData.isEmpty
          ? const EmptyState()
          : LoadedState(data: tvSeriesData),
    );

    emit(resultState);
  }
}
