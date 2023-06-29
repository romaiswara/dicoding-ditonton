import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MovieDetailCubit>(
    as: #MockMovieDetailCubit,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<MovieWatchlistStatusCubit>(
    as: #MockMovieWatchlistStatusCubit,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<MovieWatchlistActionCubit>(
    as: #MockMovieWatchlistActionCubit,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late MockMovieDetailCubit mockMovieDetailCubit;
  late MockMovieWatchlistStatusCubit mockMovieWatchlistStatusCubit;
  late MockMovieWatchlistActionCubit mockMovieWatchlistActionCubit;

  setUp(() {
    mockMovieDetailCubit = MockMovieDetailCubit();
    mockMovieWatchlistStatusCubit = MockMovieWatchlistStatusCubit();
    mockMovieWatchlistActionCubit = MockMovieWatchlistActionCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailCubit>.value(
          value: mockMovieDetailCubit,
        ),
        BlocProvider<MovieWatchlistStatusCubit>.value(
          value: mockMovieWatchlistStatusCubit,
        ),
        BlocProvider<MovieWatchlistActionCubit>.value(
          value: mockMovieWatchlistActionCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.state)
        .thenReturn(const LoadedState(data: testMovieDetail));
    when(mockMovieWatchlistStatusCubit.state).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.state)
        .thenReturn(const LoadedState(data: testMovieDetail));
    when(mockMovieWatchlistStatusCubit.state).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
