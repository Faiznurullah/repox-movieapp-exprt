import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'watchlist_tv_series_event.dart';
import 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc({
    required this.getWatchlistTvSeries,
  }) : super(WatchlistTvSeriesEmpty()) {
    on<FetchWatchlistTvSeries>((event, emit) async {
      emit(WatchlistTvSeriesLoading());

      final result = await getWatchlistTvSeries.execute();

      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure.message)),
        (tvSeries) => emit(WatchlistTvSeriesLoaded(tvSeries)),
      );
    });
  }
}
