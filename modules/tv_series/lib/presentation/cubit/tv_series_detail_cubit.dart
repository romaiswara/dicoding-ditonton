import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/cubit/base_state.dart';

class TvSeriesDetailCubit extends Cubit<BaseState<TvSeriesDetail>> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesDetailCubit({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
  }) : super(const InitializedState());

  void get({required int id}) async {
    emit(const LoadingState());
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);

    BaseState<TvSeriesDetail> resultState = detailResult.fold(
      (failure) => ErrorState(message: failure.message),
      (tvSeriesDetail) {
        return recommendationResult.fold(
          (failure) => ErrorState(message: failure.message),
          (recommendations) => LoadedState(
            data: tvSeriesDetail.updateRecommendations(
              recommendations: recommendations,
            ),
          ),
        );
      },
    );

    emit(resultState);
  }
}
