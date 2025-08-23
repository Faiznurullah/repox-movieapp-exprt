import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'top_rated_movies_event.dart';
import 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedMoviesError(failure.message)),
        (movies) => emit(TopRatedMoviesLoaded(movies)),
      );
    });
  }
}
