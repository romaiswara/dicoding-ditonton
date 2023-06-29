import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'airing_today_tv_series_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AiringTodayTvSeriesCubit>(
    as: #MockAiringTodayTvSeriesCubit,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockAiringTodayTvSeriesCubit mockAiringTodayTvSeriesCubit;

  setUp(() {
    mockAiringTodayTvSeriesCubit = MockAiringTodayTvSeriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<AiringTodayTvSeriesCubit>.value(
      value: mockAiringTodayTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockAiringTodayTvSeriesCubit.state).thenReturn(const LoadingState());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(_makeTestableWidget(const AiringTodayTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display `Terjadi kesalahan!` when error',
      (WidgetTester tester) async {
    when(mockAiringTodayTvSeriesCubit.state).thenReturn(const ErrorState());

    final errorFinder = find.text('Terjadi kesalahan!');
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(_makeTestableWidget(const AiringTodayTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(errorFinder, findsOneWidget);
  });

  testWidgets('Page should display `Tidak ada data!` when error',
      (WidgetTester tester) async {
    when(mockAiringTodayTvSeriesCubit.state).thenReturn(const EmptyState());

    final noDataFinder = find.text('Tidak ada data!');
    final centerFinder = find.byType(Center);

    await tester
        .pumpWidget(_makeTestableWidget(const AiringTodayTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(noDataFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockAiringTodayTvSeriesCubit.state)
        .thenReturn(const LoadedState(data: [tvSeriesTest]));

    final listViewFinder = find.byType(ListView);

    await tester
        .pumpWidget(_makeTestableWidget(const AiringTodayTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
