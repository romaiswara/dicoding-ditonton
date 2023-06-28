import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController tabController;

  final List<Widget> children = [
    const WatchlistTvSeriesTab(),
    const WatchlistMovieTab(),
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

  @override
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
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: kMikadoYellow,
          tabs: const [
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
