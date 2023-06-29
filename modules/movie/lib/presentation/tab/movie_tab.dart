import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';
import 'package:movie/presentation/presentation.dart';

class MovieTab extends StatelessWidget {
  const MovieTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMoviesCubit, BaseState<List<Movie>>>(
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
                  return MovieList(data);
                }
                return const SizedBox();
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                popularMoviesRoute,
              ),
            ),
            BlocBuilder<PopularMoviesCubit, BaseState<List<Movie>>>(
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
                  return MovieList(data);
                }
                return const SizedBox();
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                topRatedMoviesRoute,
              ),
            ),
            BlocBuilder<TopRatedMoviesCubit, BaseState<List<Movie>>>(
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
                  return MovieList(data);
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailMovieRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
