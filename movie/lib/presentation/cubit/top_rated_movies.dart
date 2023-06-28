import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/cubit/base_state.dart';

class TopRatedMoviesCubit extends Cubit<BaseState<List<Movie>>> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesCubit({required this.getTopRatedMovies})
      : super(const InitializedState());

  void get() async {
    emit(const LoadingState());
    final result = await getTopRatedMovies.execute();

    BaseState<List<Movie>> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (movies) =>
          movies.isEmpty ? const EmptyState() : LoadedState(data: movies),
    );

    emit(resultState);
  }
}
