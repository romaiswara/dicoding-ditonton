import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/cubit/base_state.dart';

class MovieDetailCubit extends Cubit<BaseState<MovieDetail>> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  }) : super(const InitializedState());

  void get({required int id}) async {
    emit(const LoadingState());
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);

    BaseState<MovieDetail> resultState = detailResult.fold(
      (failure) => ErrorState(message: failure.message),
      (movieDetail) {
        return recommendationResult.fold(
          (failure) => ErrorState(message: failure.message),
          (recommendations) => LoadedState(
            data: movieDetail.updateRecommendations(
              recommendations: recommendations,
            ),
          ),
        );
      },
    );

    emit(resultState);
  }
}
