import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AiringTodayTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnTheAirTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        navigatorObservers: [routeObserver],
        initialRoute: homeRoute,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homeRoute:
              return MaterialPageRoute(builder: (_) => HomePage());
            case airingTodayTvSeriesRoute:
              return MaterialPageRoute(
                  builder: (_) => AiringTodayTvSeriesPage());
            case onTheAirTvSeriesRoute:
              return MaterialPageRoute(builder: (_) => OnTheAirTvSeriesPage());
            case popularTvSeriesRoute:
              return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());
            case topRatedTvSeriesRoute:
              return MaterialPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case detailTvSeriesRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case popularMoviesRoute:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMoviesRoute:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchRoute:
              return MaterialPageRoute(builder: (_) => SearchPage());
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
