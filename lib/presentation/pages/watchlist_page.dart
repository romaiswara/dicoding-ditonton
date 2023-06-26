import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/watchlist_tab/watchlist_movie_tab.dart';
import 'package:ditonton/presentation/pages/watchlist_tab/watchlist_tv_series_tab.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController tabController;

  final List<Widget> children = [
    WatchlistTvSeriesTab(),
    WatchlistMovieTab(),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    Future.microtask(() {
      // tv series
      Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
          .fetchWatchlistTvSeries();

      // movie
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    // tv series
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();

    // movie
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
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
