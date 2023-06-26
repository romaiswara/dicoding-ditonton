import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_series_page.dart';
import 'package:ditonton/presentation/provider/on_the_air_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_series_page_test.mocks.dart';

@GenerateMocks([OnTheAirTvSeriesNotifier])
void main() {
  late MockOnTheAirTvSeriesNotifier mockOnTheAirTvSeriesNotifier;

  setUp(() {
    mockOnTheAirTvSeriesNotifier = MockOnTheAirTvSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnTheAirTvSeriesNotifier>.value(
      value: mockOnTheAirTvSeriesNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockOnTheAirTvSeriesNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockOnTheAirTvSeriesNotifier.state).thenReturn(RequestState.Loaded);
    when(mockOnTheAirTvSeriesNotifier.tvSeries)
        .thenReturn(<TvSeries>[tvSeriesTest]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockOnTheAirTvSeriesNotifier.state).thenReturn(RequestState.Error);
    when(mockOnTheAirTvSeriesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
