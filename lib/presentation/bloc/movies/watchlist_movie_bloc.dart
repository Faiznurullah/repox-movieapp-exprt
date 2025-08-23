import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'watchlist_movie_event.dart';
import 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchlistMovieBloc({
    required this.getWatchlistMovies,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (movies) => emit(WatchlistMovieLoaded(movies)),
      );
    });

    on<AddWatchlistMovie>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (successMessage) => emit(WatchlistMovieSuccess(successMessage)),
      );
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (successMessage) => emit(WatchlistMovieSuccess(successMessage)),
      );
    });
  }
}
