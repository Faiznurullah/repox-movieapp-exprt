import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovies extends WatchlistMovieEvent {}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
