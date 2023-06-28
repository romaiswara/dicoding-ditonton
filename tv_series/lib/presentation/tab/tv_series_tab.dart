import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

class TvSeriesTab extends StatelessWidget {
  const TvSeriesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Airing Today',
              onTap: () => Navigator.pushNamed(
                context,
                airingTodayTvSeriesRoute,
              ),
            ),

            /// airing today
            BlocBuilder<AiringTodayTvSeriesCubit, BaseState<List<TvSeries>>>(
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
                  final List<TvSeries> data = state.data ?? [];
                  return TvSeriesList(data);
                }
                return const SizedBox();
              },
            ),

            _buildSubHeading(
              title: 'On The Air',
              onTap: () => Navigator.pushNamed(
                context,
                onTheAirTvSeriesRoute,
              ),
            ),

            BlocBuilder<OnTheAirTvSeriesCubit, BaseState<List<TvSeries>>>(
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
                  final List<TvSeries> data = state.data ?? [];
                  return TvSeriesList(data);
                }
                return const SizedBox();
              },
            ),

            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(
                context,
                popularTvSeriesRoute,
              ),
            ),

            BlocBuilder<PopularTvSeriesCubit, BaseState<List<TvSeries>>>(
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
                  final List<TvSeries> data = state.data ?? [];
                  return TvSeriesList(data);
                }
                return const SizedBox();
              },
            ),

            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(
                context,
                topRatedTvSeriesRoute,
              ),
            ),

            BlocBuilder<TopRatedTvSeriesCubit, BaseState<List<TvSeries>>>(
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
                  final List<TvSeries> data = state.data ?? [];
                  return TvSeriesList(data);
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

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const TvSeriesList(this.tvSeriesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailTvSeriesRoute,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
