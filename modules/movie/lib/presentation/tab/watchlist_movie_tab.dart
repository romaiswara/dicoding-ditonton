import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/presentation.dart';

class WatchlistMovieTab extends StatelessWidget {
  const WatchlistMovieTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesCubit, BaseState<List<Movie>>>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return const Center(
              child: Text('Terjadi kesalahan!'),
            );
          }
          if (state is EmptyState) {
            return const Center(
              child: Text('Tidak ada data!'),
            );
          }
          if (state is LoadedState) {
            final List<Movie> data = state.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = data[index];
                return MovieCard(movie);
              },
              itemCount: data.length,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
