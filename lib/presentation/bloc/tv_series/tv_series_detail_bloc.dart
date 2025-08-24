import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'tv_series_detail_event.dart';
import 'tv_series_detail_state.dart';

class TvSeriesDetailBloc extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getTvSeriesWatchListStatus,
  }) : super(TvSeriesDetailEmpty()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(TvSeriesDetailLoading());

      final detailResult = await getTvSeriesDetail.execute(event.id);
      final recommendationResult = await getTvSeriesRecommendations.execute(event.id);
      final watchlistStatus = await getTvSeriesWatchListStatus.execute(event.id);

      detailResult.fold(
        (failure) => emit(TvSeriesDetailError(failure.message)),
        (tvSeriesDetail) {
          recommendationResult.fold(
            (failure) => emit(TvSeriesDetailError(failure.message)),
            (recommendations) => emit(TvSeriesDetailLoaded(
              tvSeriesDetail: tvSeriesDetail,
              tvSeriesRecommendations: recommendations,
              isAddedToWatchlist: watchlistStatus,
            )),
          );
        },
      );
    });
  }
}
