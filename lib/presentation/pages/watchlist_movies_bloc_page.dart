import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movies/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/watchlist_movie_event.dart';
import 'package:ditonton/presentation/bloc/movies/watchlist_movie_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesBlocPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie-bloc';

  @override
  _WatchlistMoviesBlocPageState createState() => _WatchlistMoviesBlocPageState();
}

class _WatchlistMoviesBlocPageState extends State<WatchlistMoviesBlocPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMovieBloc>().add(FetchWatchlistMovies()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text('No movies in watchlist'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else if (state is WatchlistMovieError) {
              return Center(
                key: Key('error_message'),
                child: Text('Error: ${state.message}'),
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
