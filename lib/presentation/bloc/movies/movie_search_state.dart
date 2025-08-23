import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends MovieSearchState {}

class SearchLoading extends MovieSearchState {}

class SearchLoaded extends MovieSearchState {
  final List<Movie> result;

  const SearchLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class SearchError extends MovieSearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
