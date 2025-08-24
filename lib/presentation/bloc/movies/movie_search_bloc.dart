import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/search_movies.dart' as UseCases;
import 'package:rxdart/rxdart.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final UseCases.SearchMovies searchMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  MovieSearchBloc(this.searchMovies) : super(MovieSearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(MovieSearchLoading());
        final result = await searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(MovieSearchError(failure.message));
          },
          (data) {
            emit(MovieSearchLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );

    on<SearchMovies>((event, emit) async {
      if (event is SearchMovies) {
        final query = event.query;
        emit(MovieSearchLoading());
        final result = await searchMovies.execute(query);
        result.fold(
          (failure) {
            emit(MovieSearchError(failure.message));
          },
          (data) {
            emit(MovieSearchLoaded(data));
          },
        );
      }
    });
  }
}
