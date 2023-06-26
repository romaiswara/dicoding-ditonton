import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/search_tab/search_movie_tab.dart';
import 'package:ditonton/presentation/pages/search_tab/search_tv_series_tab.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Widget> children = [
    SearchTvSeriesTab(),
    SearchMovieTab(),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              style: TextStyle(color: Colors.black54),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                prefix: SizedBox(width: 16),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
              onSubmitted: (query) {
                // tv series
                Provider.of<TvSeriesSearchNotifier>(context, listen: false)
                    .fetchTvSeriesSearch(query);

                // movie
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
            ),
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: kMikadoYellow,
          tabs: [
            Tab(text: 'Tv Series'),
            Tab(text: 'Movies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: children,
      ),
    );
  }
}
