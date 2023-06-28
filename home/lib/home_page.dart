import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> children = const [
    TvSeriesTab(),
    MovieTab(),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    Future.microtask(() {
      // get tv series
      context.read<AiringTodayTvSeriesCubit>().get();
      context.read<OnTheAirTvSeriesCubit>().get();
      context.read<PopularTvSeriesCubit>().get();
      context.read<TopRatedTvSeriesCubit>().get();

      // get movies
      context.read<NowPlayingMoviesCubit>().get();
      context.read<PopularMoviesCubit>().get();
      context.read<TopRatedMoviesCubit>().get();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                searchRoute,
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  watchlistRoute,
                );
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  aboutRoute,
                );
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
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
        items: const [
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
