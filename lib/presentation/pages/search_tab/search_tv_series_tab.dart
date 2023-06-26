import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTvSeriesTab extends StatelessWidget {
  const SearchTvSeriesTab({Key? key}) : super(key: key);

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
          Consumer<TvSeriesSearchNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.Loaded) {
                final result = data.searchResult;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final tvSeries = data.searchResult[index];
                      return TvSeriesCard(tvSeries);
                    },
                    itemCount: result.length,
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
