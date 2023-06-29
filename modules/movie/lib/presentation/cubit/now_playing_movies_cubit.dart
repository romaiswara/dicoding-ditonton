import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/cubit/base_state.dart';

class NowPlayingMoviesCubit extends Cubit<BaseState<List<Movie>>> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesCubit({required this.getNowPlayingMovies})
      : super(const InitializedState());

  void get() async {
    emit(const LoadingState());
    final result = await getNowPlayingMovies.execute();

    BaseState<List<Movie>> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (movies) =>
          movies.isEmpty ? const EmptyState() : LoadedState(data: movies),
    );

    emit(resultState);
  }
}
