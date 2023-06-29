import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TopRatedMoviesCubit>(
    as: #MockTopRatedMoviesCubit,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() {
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;

  setUp(() {
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>.value(
      value: mockTopRatedMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.state).thenReturn(const LoadingState());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display `Terjadi kesalahan!` when error',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.state).thenReturn(const ErrorState());

    final errorFinder = find.text('Terjadi kesalahan!');
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(errorFinder, findsOneWidget);
  });

  testWidgets('Page should display `Tidak ada data!` when error',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.state).thenReturn(const EmptyState());

    final noDataFinder = find.text('Tidak ada data!');
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(noDataFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(LoadedState(data: [testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}
