import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter/material.dart';

class SeasonCard extends StatelessWidget {
  final Season season;

  const SeasonCard({
    Key? key,
    required this.season,
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
                imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
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
                // season - name - total episode
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Season ${season.seasonNumber ?? 0}: ${season.name ?? '-'}',
                          style: kHeading6,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${season.episodeCount ?? 0} Episodes',
                        style: kSubtitle,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // overview
                Text(
                  'Overview',
                  style: kHeading6,
                ),
                Text(
                  season.overview ?? '-',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // air date
                Text(
                  'Air Date',
                  style: kHeading6,
                ),
                Text(season.airDate ?? '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
