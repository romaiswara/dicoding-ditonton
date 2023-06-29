import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PopularMoviesCubit>(
    as: #MockPopularMoviesCubit,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockPopularMoviesCubit mockPopularMoviesCubit;

  setUp(() {
    mockPopularMoviesCubit = MockPopularMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesCubit>.value(
      value: mockPopularMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.state).thenReturn(const LoadingState());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display `Terjadi kesalahan!` when error',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.state).thenReturn(const ErrorState());

    final errorFinder = find.text('Terjadi kesalahan!');
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(errorFinder, findsOneWidget);
  });

  testWidgets('Page should display `Tidak ada data!` when error',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.state).thenReturn(const EmptyState());

    final noDataFinder = find.text('Tidak ada data!');
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(noDataFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.state)
        .thenReturn(LoadedState(data: [testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
