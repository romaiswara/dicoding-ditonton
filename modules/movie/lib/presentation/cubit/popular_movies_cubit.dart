import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/cubit/base_state.dart';

class PopularMoviesCubit extends Cubit<BaseState<List<Movie>>> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesCubit({required this.getPopularMovies})
      : super(const InitializedState());

  void get() async {
    emit(const LoadingState());
    final result = await getPopularMovies.execute();

    BaseState<List<Movie>> resultState = result.fold(
      (failure) => ErrorState(message: failure.message),
      (movies) =>
          movies.isEmpty ? const EmptyState() : LoadedState(data: movies),
    );

    emit(resultState);
  }
}
