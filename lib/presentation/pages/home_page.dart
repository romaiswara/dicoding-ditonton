import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_tab/movie_tab.dart';
import 'package:ditonton/presentation/pages/home_tab/tv_series_tab.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> children = [
    TvSeriesTab(),
    MovieTab(),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    Future.microtask(() {
      // get tv series
      Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..fetchAiringTodayTvSeries()
        ..fetchOnTheAirTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries();

      // get movies
      Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: kMikadoYellow,
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Tv Series',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
        ],
      ),
    );
  }
}
