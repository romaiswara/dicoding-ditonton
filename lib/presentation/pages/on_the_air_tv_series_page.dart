import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/on_the_air_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv-series';

  @override
  _OnTheAirTvSeriesPageState createState() => _OnTheAirTvSeriesPageState();
}

class _OnTheAirTvSeriesPageState extends State<OnTheAirTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvSeriesNotifier>(context, listen: false)
            .fetchOnTheAirTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: data.tvSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
