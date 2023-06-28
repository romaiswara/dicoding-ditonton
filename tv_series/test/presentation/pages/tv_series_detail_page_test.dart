import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockTvSeriesDetailNotifier;

  const int dummyId = 31910;

  setUp(() {
    mockTvSeriesDetailNotifier = MockTvSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
      value: mockTvSeriesDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tvSeries not added to watchlist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.tvSeriesState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeries).thenReturn(tvSeriesDetailTest);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tvSeriesRecommendationTest]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: dummyId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tvSeries is added to wathclist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.tvSeriesState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeries).thenReturn(tvSeriesDetailTest);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tvSeriesRecommendationTest]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: dummyId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.tvSeriesState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeries).thenReturn(tvSeriesDetailTest);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tvSeriesRecommendationTest]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvSeriesDetailNotifier.watchlistMessage)
        .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: dummyId)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailNotifier.tvSeriesState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeries).thenReturn(tvSeriesDetailTest);
    when(mockTvSeriesDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvSeriesDetailNotifier.tvSeriesRecommendations)
        .thenReturn(<TvSeries>[tvSeriesRecommendationTest]);
    when(mockTvSeriesDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvSeriesDetailNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: dummyId)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
