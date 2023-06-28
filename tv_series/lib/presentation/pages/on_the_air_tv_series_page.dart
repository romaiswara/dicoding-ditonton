import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

class OnTheAirTvSeriesPage extends StatefulWidget {
  const OnTheAirTvSeriesPage({super.key});

  @override
  _OnTheAirTvSeriesPageState createState() => _OnTheAirTvSeriesPageState();
}

class _OnTheAirTvSeriesPageState extends State<OnTheAirTvSeriesPage> {
  @override
  void initState() {
    context.read<OnTheAirTvSeriesCubit>().get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvSeriesCubit, BaseState<List<TvSeries>>>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorState) {
              return const Center(
                child: Text('Terjadi kesalahan!'),
              );
            }
            if (state is EmptyState) {
              return const Center(
                child: Text('Tidak ada data!'),
              );
            }
            if (state is LoadedState) {
              final List<TvSeries> data = state.data ?? [];
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.length,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
