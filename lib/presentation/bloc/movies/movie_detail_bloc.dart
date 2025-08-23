import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
  }) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());

      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult = await getMovieRecommendations.execute(event.id);
      final watchlistStatus = await getWatchListStatus.execute(event.id);

      detailResult.fold(
        (failure) => emit(MovieDetailError(failure.message)),
        (movie) {
          recommendationResult.fold(
            (failure) => emit(MovieDetailError(failure.message)),
            (recommendations) => emit(MovieDetailLoaded(
              movieDetail: movie,
              movieRecommendations: recommendations,
              isAddedToWatchlist: watchlistStatus,
            )),
          );
        },
      );
    });
  }
}
