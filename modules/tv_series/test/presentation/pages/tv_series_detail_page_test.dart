import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TvSeriesDetailCubit>(
    as: #MockTvSeriesDetailCubit,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<TvSeriesWatchlistStatusCubit>(
    as: #MockTvSeriesWatchlistStatusCubit,
    onMissingStub: OnMissingStub.returnDefault,
  ),
  MockSpec<TvSeriesWatchlistActionCubit>(
    as: #MockTvSeriesWatchlistActionCubit,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late MockTvSeriesDetailCubit mockTvSeriesDetailCubit;
  late MockTvSeriesWatchlistStatusCubit mockTvSeriesWatchlistStatusCubit;
  late MockTvSeriesWatchlistActionCubit mockTvSeriesWatchlistActionCubit;

  const int dummyId = 31910;
  const TvSeriesDetail dummyTvSeriesDetail = tvSeriesDetailTest;

  setUp(() {
    mockTvSeriesDetailCubit = MockTvSeriesDetailCubit();
    mockTvSeriesWatchlistStatusCubit = MockTvSeriesWatchlistStatusCubit();
    mockTvSeriesWatchlistActionCubit = MockTvSeriesWatchlistActionCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailCubit>.value(
          value: mockTvSeriesDetailCubit,
        ),
        BlocProvider<TvSeriesWatchlistStatusCubit>.value(
          value: mockTvSeriesWatchlistStatusCubit,
        ),
        BlocProvider<TvSeriesWatchlistActionCubit>.value(
          value: mockTvSeriesWatchlistActionCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tvSeries not added to watchlist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailCubit.state)
        .thenReturn(const LoadedState(data: dummyTvSeriesDetail));
    when(mockTvSeriesWatchlistStatusCubit.state).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: dummyId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tvSeries is added to wathclist',
      (WidgetTester tester) async {
    when(mockTvSeriesDetailCubit.state)
        .thenReturn(const LoadedState(data: dummyTvSeriesDetail));
    when(mockTvSeriesWatchlistStatusCubit.state).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const TvSeriesDetailPage(id: dummyId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
