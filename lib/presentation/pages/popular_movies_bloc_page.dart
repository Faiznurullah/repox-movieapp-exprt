import 'package:ditonton/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/popular_movies_event.dart';
import 'package:ditonton/presentation/bloc/movies/popular_movies_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesBlocPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie-bloc';

  @override
  _PopularMoviesBlocPageState createState() => _PopularMoviesBlocPageState();
}

class _PopularMoviesBlocPageState extends State<PopularMoviesBlocPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularMoviesBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies (BLoC)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else if (state is PopularMoviesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}
