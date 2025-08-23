import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> movieRecommendations;
  final bool isAddedToWatchlist;

  const MovieDetailLoaded({
    required this.movieDetail,
    required this.movieRecommendations,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object> get props => [movieDetail, movieRecommendations, isAddedToWatchlist];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}
