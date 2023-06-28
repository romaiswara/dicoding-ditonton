import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/data.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/cubit/base_state.dart';

class MovieWatchlistActionCubit extends Cubit<BaseState<String>> {
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;

  MovieWatchlistActionCubit({
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
  }) : super(const InitializedState());

  void add({required MovieDetail detail}) async {
    emit(const LoadingState());

    // convert to table
    MovieTable movieTable = MovieTable.fromEntity(detail);
    final result = await saveWatchlistMovie.execute(movieTable.toJson());

    BaseState<String> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (success) => SuccessState(data: success),
    );

    emit(resultState);
  }

  void remove({required int id}) async {
    emit(const LoadingState());

    final result = await removeWatchlistMovie.execute(id);

    BaseState<String> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (success) => SuccessState(data: success),
    );

    emit(resultState);
  }
}
