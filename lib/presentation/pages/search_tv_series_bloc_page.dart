import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_search_state.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTvSeriesBlocPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv-series-bloc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<TvSeriesSearchBloc>().add(SearchTvSeries(query));
              },
              decoration: InputDecoration(
                hintText: 'Search TV series...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
                builder: (context, state) {
                  if (state is TvSeriesSearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvSeriesSearchLoaded) {
                    final result = state.tvSeries;
                    if (result.isEmpty) {
                      return Center(
                        child: Text('No TV series found'),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tvSeries = result[index];
                        return TvSeriesCard(tvSeries);
                      },
                      itemCount: result.length,
                    );
                  } else if (state is TvSeriesSearchError) {
                    return Center(
                      child: Text('Error: ${state.message}'),
                    );
                  } else {
                    return Center(
                      child: Text('Start searching for TV series!'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
