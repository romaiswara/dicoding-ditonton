import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/cubit/base_state.dart';

class WatchlistMoviesCubit extends Cubit<BaseState<List<Movie>>> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesCubit({required this.getWatchlistMovies})
      : super(const InitializedState());

  void get() async {
    emit(const LoadingState());
    final result = await getWatchlistMovies.execute();

    BaseState<List<Movie>> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (movies) =>
          movies.isEmpty ? const EmptyState() : LoadedState(data: movies),
    );

    emit(resultState);
  }
}
