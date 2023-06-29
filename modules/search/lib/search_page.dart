import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Widget> children = const [
    SearchTvSeriesTab(),
    SearchMovieTab(),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              style: const TextStyle(color: Colors.black54),
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                prefix: SizedBox(width: 16),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
              onSubmitted: (query) {
                // tv series
                context.read<TvSeriesSearchCubit>().get(query: query);

                // movie
                context.read<MovieSearchCubit>().get(query: query);
              },
            ),
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: kMikadoYellow,
          tabs: const [
            Tab(text: 'Tv Series'),
            Tab(text: 'Movies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: children,
      ),
    );
  }
}
