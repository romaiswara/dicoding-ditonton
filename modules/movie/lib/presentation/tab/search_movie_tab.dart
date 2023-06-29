import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/presentation.dart';

class SearchMovieTab extends StatelessWidget {
  const SearchMovieTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Result',
            style: kHeading6,
          ),
          BlocBuilder<MovieSearchCubit, BaseState<List<Movie>>>(
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
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      return MovieCard(movie);
                    },
                    itemCount: data.length,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
