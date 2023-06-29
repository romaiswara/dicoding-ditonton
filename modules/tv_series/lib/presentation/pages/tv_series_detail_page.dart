import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;

  const TvSeriesDetailPage({super.key, required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    // get detail
    context.read<TvSeriesDetailCubit>().get(id: widget.id);
    // get status
    context.read<TvSeriesWatchlistStatusCubit>().get(id: widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TvSeriesWatchlistActionCubit, BaseState<String>>(
        listener: (context, actionState) {
          if (actionState is ErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text('Terjadi Kesalahan, coba lagi!'),
                );
              },
            );
          }
          if (actionState is SuccessState) {
            context.read<TvSeriesWatchlistStatusCubit>().get(id: widget.id);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(actionState.data!)));
          }
        },
        child: BlocBuilder<TvSeriesDetailCubit, BaseState<TvSeriesDetail>>(
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
            if (state is LoadedState) {
              final TvSeriesDetail data = state.data!;
              return DetailContent(data);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail detail;

  const DetailContent(this.detail, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${detail.posterPath}',
            width: screenWidth,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detail.name ?? '-',
                                style: kHeading5,
                              ),
                              BlocBuilder<TvSeriesWatchlistStatusCubit, bool>(
                                builder: (context, isAddedWatchlist) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!isAddedWatchlist) {
                                        context
                                            .read<
                                                TvSeriesWatchlistActionCubit>()
                                            .add(detail: detail);
                                      } else {
                                        context
                                            .read<
                                                TvSeriesWatchlistActionCubit>()
                                            .remove(id: detail.id);
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Text(
                                _showGenres(detail.genres ?? []),
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: (detail.voteAverage ?? 0) / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text(
                                      '${(detail.voteAverage ?? 0).toStringAsFixed(1)} (${detail.voteCount ?? 0})')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                detail.overview ?? '-',
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'First Air Date',
                                style: kHeading6,
                              ),
                              Text(
                                detail.firstAirDate ?? '-',
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Last Air Date',
                                style: kHeading6,
                              ),
                              Text(
                                detail.lastAirDate ?? '-',
                              ),
                              const SizedBox(height: 16),
                              if (detail.lastEpisodeToAir != null) ...[
                                Text(
                                  'Last Episode',
                                  style: kHeading6,
                                ),
                                const SizedBox(height: 8),
                                EpisodeCard(episode: detail.lastEpisodeToAir!),
                                const SizedBox(height: 16),
                              ],
                              if (detail.nextEpisodeToAir != null) ...[
                                Text(
                                  'Next Episode',
                                  style: kHeading6,
                                ),
                                const SizedBox(height: 8),
                                EpisodeCard(episode: detail.nextEpisodeToAir!),
                                const SizedBox(height: 16),
                              ],
                              if (detail.seasons?.isNotEmpty ?? false) ...[
                                Text(
                                  'All Season:',
                                  style: kHeading6,
                                ),
                                const SizedBox(height: 8),
                                ...List.generate(
                                  detail.seasons!.length,
                                  (index) => Container(
                                    margin: EdgeInsets.only(
                                        top: index == 0 ? 0 : 16),
                                    child: SeasonCard(
                                      season: detail.seasons![index],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                              if (detail.recommendations?.isNotEmpty ??
                                  false) ...[
                                Text(
                                  'Recommendations',
                                  style: kHeading6,
                                ),
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tvSeries =
                                          detail.recommendations![index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              detailTvSeriesRoute,
                                              arguments: tvSeries.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: detail.recommendations!.length,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // initialChildSize: 0.5,
              minChildSize: 0.25,
              // maxChildSize: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
