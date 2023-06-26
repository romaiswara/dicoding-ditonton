import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({
    Key? key,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // image
          AspectRatio(
            aspectRatio: 1.85 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                width: double.infinity,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // title - rating
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          episode.name ?? '-',
                          style: kHeading6,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: (episode.voteAverage ?? 0) / 2,
                            itemCount: 5,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: kMikadoYellow,
                            ),
                            itemSize: 12,
                          ),
                          const SizedBox(width: 8),
                          Text(
                              '${(episode.voteAverage ?? 0).toStringAsFixed(1)} (${episode.voteCount ?? 0})')
                        ],
                      ),
                    ],
                  ),
                ),

                // episode - season
                Text(
                  'Episode ${episode.episodeNumber ?? 0} - Season ${episode.seasonNumber ?? 0}',
                ),

                // duration
                Text(
                  _showDuration(episode.runtime ?? 0),
                ),

                const SizedBox(height: 8),

                // overview
                Text(
                  'Overview',
                  style: kHeading6,
                ),
                Text(
                  episode.overview ?? '-',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // air date
                Text(
                  'Air Date',
                  style: kHeading6,
                ),
                Text(episode.airDate ?? '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
