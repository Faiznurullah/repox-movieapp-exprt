import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movies/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_search_event.dart';
import 'package:ditonton/presentation/bloc/movies/movie_search_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBlocPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-bloc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<MovieSearchBloc>().add(SearchMovies(query));
              },
              decoration: InputDecoration(
                hintText: 'Search movies...',
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
              child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieSearchLoaded) {
                    final result = state.movies;
                    if (result.isEmpty) {
                      return Center(
                        child: Text('No movies found'),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    );
                  } else if (state is MovieSearchError) {
                    return Center(
                      child: Text('Error: ${state.message}'),
                    );
                  } else {
                    return Center(
                      child: Text('Start searching for movies!'),
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
