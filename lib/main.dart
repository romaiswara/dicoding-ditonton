import 'dart:io';

import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/home.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final sslCert = await rootBundle.load('assets/certificates/certificates.cer');
  final SecurityContext securityContext =
      SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  runApp(MyApp(securityContext: securityContext));
}

class MyApp extends StatefulWidget {
  final SecurityContext securityContext;

  MyApp({
    required this.securityContext,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// client
  late DioClient dioClient;
  late DatabaseHelper databaseHelper;

  /// data sources
  late TvSeriesRemoteDataSource tvSeriesRemoteDataSource;
  late TvSeriesLocalDataSource tvSeriesLocalDataSource;
  late MovieRemoteDataSource movieRemoteDataSource;
  late MovieLocalDataSource movieLocalDataSource;

  /// repository
  late TvSeriesRepository tvSeriesRepository;
  late MovieRepository movieRepository;

  /// TV Series usecase
  late GetAiringTodayTvSeries getAiringTodayTvSeries;
  late GetOnTheAirTvSeries getOnTheAirTvSeries;
  late GetPopularTvSeries getPopularTvSeries;
  late GetTopRatedTvSeries getTopRatedTvSeries;
  late GetTvSeriesDetail getTvSeriesDetail;
  late GetTvSeriesRecommendations getTvSeriesRecommendations;
  late GetWatchlistTvSeries getWatchlistTvSeries;
  late GetWatchListTvSeriesStatus getWatchListTvSeriesStatus;
  late RemoveWatchlistTvSeries removeWatchlistTvSeries;
  late SaveWatchlistTvSeries saveWatchlistTvSeries;
  late SearchTvSeries searchTvSeries;

  /// Movie usecase
  late GetNowPlayingMovies getNowPlayingMovies;
  late GetPopularMovies getPopularMovies;
  late GetTopRatedMovies getTopRatedMovies;
  late GetMovieDetail getMovieDetail;
  late GetMovieRecommendations getMovieRecommendations;
  late GetWatchlistMovies getWatchlistMovies;
  late GetWatchListStatus getWatchListStatus;
  late RemoveWatchlistMovie removeWatchlistMovie;
  late SaveWatchlistMovie saveWatchlistMovie;
  late SearchMovies searchMovies;

  @override
  void initState() {
    initAll();
    super.initState();
  }

  void initAll() {
    /// client
    dioClient = DioClient(securityContext: widget.securityContext);
    databaseHelper = DatabaseHelper();

    /// data sources
    tvSeriesRemoteDataSource = TvSeriesRemoteDataSourceImpl(
      client: dioClient,
    );
    tvSeriesLocalDataSource = TvSeriesLocalDataSourceImpl(
      databaseHelper: databaseHelper,
    );
    movieRemoteDataSource = MovieRemoteDataSourceImpl(
      client: dioClient,
    );
    movieLocalDataSource = MovieLocalDataSourceImpl(
      databaseHelper: databaseHelper,
    );

    /// repository
    tvSeriesRepository = TvSeriesRepositoryImpl(
      remoteDataSource: tvSeriesRemoteDataSource,
      localDataSource: tvSeriesLocalDataSource,
    );
    movieRepository = MovieRepositoryImpl(
      remoteDataSource: movieRemoteDataSource,
      localDataSource: movieLocalDataSource,
    );

    /// tv series
    getAiringTodayTvSeries = GetAiringTodayTvSeries(
      tvSeriesRepository,
    );
    getOnTheAirTvSeries = GetOnTheAirTvSeries(
      tvSeriesRepository,
    );
    getPopularTvSeries = GetPopularTvSeries(
      tvSeriesRepository,
    );
    getTopRatedTvSeries = GetTopRatedTvSeries(
      tvSeriesRepository,
    );
    getTvSeriesDetail = GetTvSeriesDetail(
      tvSeriesRepository,
    );
    getTvSeriesRecommendations = GetTvSeriesRecommendations(
      tvSeriesRepository,
    );
    getWatchlistTvSeries = GetWatchlistTvSeries(
      tvSeriesRepository,
    );
    getWatchListTvSeriesStatus = GetWatchListTvSeriesStatus(
      tvSeriesRepository,
    );
    removeWatchlistTvSeries = RemoveWatchlistTvSeries(
      tvSeriesRepository,
    );
    saveWatchlistTvSeries = SaveWatchlistTvSeries(
      tvSeriesRepository,
    );
    searchTvSeries = SearchTvSeries(
      tvSeriesRepository,
    );

    /// movie
    getNowPlayingMovies = GetNowPlayingMovies(
      movieRepository,
    );
    getPopularMovies = GetPopularMovies(
      movieRepository,
    );
    getTopRatedMovies = GetTopRatedMovies(
      movieRepository,
    );
    getMovieDetail = GetMovieDetail(
      movieRepository,
    );
    getMovieRecommendations = GetMovieRecommendations(
      movieRepository,
    );
    getWatchlistMovies = GetWatchlistMovies(
      movieRepository,
    );
    getWatchListStatus = GetWatchListStatus(
      movieRepository,
    );
    removeWatchlistMovie = RemoveWatchlistMovie(
      movieRepository,
    );
    saveWatchlistMovie = SaveWatchlistMovie(
      movieRepository,
    );
    searchMovies = SearchMovies(
      movieRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => dioClient,
        ),
        RepositoryProvider(
          create: (_) => databaseHelper,
        ),
        RepositoryProvider(
          create: (_) => tvSeriesRemoteDataSource,
        ),
        RepositoryProvider(
          create: (_) => tvSeriesLocalDataSource,
        ),
        RepositoryProvider(
          create: (_) => movieRemoteDataSource,
        ),
        RepositoryProvider(
          create: (_) => movieRemoteDataSource,
        ),
        RepositoryProvider(
          create: (_) => tvSeriesRepository,
        ),
        RepositoryProvider(
          create: (_) => movieRepository,
        ),
        RepositoryProvider(
          create: (_) => getAiringTodayTvSeries,
        ),
        RepositoryProvider(
          create: (_) => getOnTheAirTvSeries,
        ),
        RepositoryProvider(
          create: (_) => getPopularTvSeries,
        ),
        RepositoryProvider(
          create: (_) => getTopRatedTvSeries,
        ),
        RepositoryProvider(
          create: (_) => getTvSeriesDetail,
        ),
        RepositoryProvider(
          create: (_) => getTvSeriesRecommendations,
        ),
        RepositoryProvider(
          create: (_) => getWatchlistTvSeries,
        ),
        RepositoryProvider(
          create: (_) => getWatchListTvSeriesStatus,
        ),
        RepositoryProvider(
          create: (_) => removeWatchlistTvSeries,
        ),
        RepositoryProvider(
          create: (_) => saveWatchlistTvSeries,
        ),
        RepositoryProvider(
          create: (_) => searchTvSeries,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AiringTodayTvSeriesCubit(
              getAiringTodayTvSeries: getAiringTodayTvSeries,
            ),
          ),
          BlocProvider(
            create: (_) => OnTheAirTvSeriesCubit(
              getOnTheAirTvSeries: getOnTheAirTvSeries,
            ),
          ),
          BlocProvider(
            create: (_) => PopularTvSeriesCubit(
              getPopularTvSeries: getPopularTvSeries,
            ),
          ),
          BlocProvider(
            create: (_) => TopRatedTvSeriesCubit(
              getTopRatedTvSeries: getTopRatedTvSeries,
            ),
          ),
          BlocProvider(
            create: (_) => TvSeriesDetailCubit(
              getTvSeriesDetail: getTvSeriesDetail,
              getTvSeriesRecommendations: getTvSeriesRecommendations,
            ),
          ),
          BlocProvider(
            create: (_) => TvSeriesWatchlistStatusCubit(
              getWatchListTvSeriesStatus: getWatchListTvSeriesStatus,
            ),
          ),
          BlocProvider(
            create: (_) => TvSeriesWatchlistActionCubit(
              saveWatchlistTvSeries: saveWatchlistTvSeries,
              removeWatchlistTvSeries: removeWatchlistTvSeries,
            ),
          ),
          BlocProvider(
            create: (_) => TvSeriesSearchCubit(
              searchTvSeries: searchTvSeries,
            ),
          ),
          BlocProvider(
            create: (_) => WatchlistTvSeriesCubit(
              getWatchlistTvSeries: getWatchlistTvSeries,
            ),
          ),
          BlocProvider(
            create: (_) => NowPlayingMoviesCubit(
              getNowPlayingMovies: getNowPlayingMovies,
            ),
          ),
          BlocProvider(
            create: (_) => PopularMoviesCubit(
              getPopularMovies: getPopularMovies,
            ),
          ),
          BlocProvider(
            create: (_) => TopRatedMoviesCubit(
              getTopRatedMovies: getTopRatedMovies,
            ),
          ),
          BlocProvider(
            create: (_) => MovieDetailCubit(
              getMovieDetail: getMovieDetail,
              getMovieRecommendations: getMovieRecommendations,
            ),
          ),
          BlocProvider(
            create: (_) => MovieWatchlistStatusCubit(
              getWatchListStatus: getWatchListStatus,
            ),
          ),
          BlocProvider(
            create: (_) => MovieWatchlistActionCubit(
              removeWatchlistMovie: removeWatchlistMovie,
              saveWatchlistMovie: saveWatchlistMovie,
            ),
          ),
          BlocProvider(
            create: (_) => MovieSearchCubit(
              searchMovies: searchMovies,
            ),
          ),
          BlocProvider(
            create: (_) => WatchlistMoviesCubit(
              getWatchlistMovies: getWatchlistMovies,
            ),
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
                return MaterialPageRoute(
                    builder: (_) => OnTheAirTvSeriesPage());
              case popularTvSeriesRoute:
                return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());
              case topRatedTvSeriesRoute:
                return MaterialPageRoute(
                    builder: (_) => TopRatedTvSeriesPage());
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
      ),
    );
  }
}
