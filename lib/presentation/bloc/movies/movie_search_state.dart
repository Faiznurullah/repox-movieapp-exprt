import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchEmpty extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> movies;

  const MovieSearchLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError(this.message);

  @override
  List<Object> get props => [message];
}

// Legacy states for compatibility
class SearchEmpty extends MovieSearchEmpty {}
class SearchLoading extends MovieSearchLoading {}
class SearchLoaded extends MovieSearchLoaded {
  const SearchLoaded(List<Movie> result) : super(result);
  List<Movie> get result => movies;
}
class SearchError extends MovieSearchError {
  const SearchError(String message) : super(message);
}
