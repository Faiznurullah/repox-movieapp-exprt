import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart' as UseCases;
import 'tv_series_search_event.dart';
import 'tv_series_search_state.dart';

class TvSeriesSearchBloc extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final UseCases.SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc(this.searchTvSeries) : super(TvSeriesSearchEmpty()) {
    on<SearchTvSeries>((event, emit) async {
      emit(TvSeriesSearchLoading());

      final result = await searchTvSeries.execute(event.query);

      result.fold(
        (failure) => emit(TvSeriesSearchError(failure.message)),
        (tvSeries) => emit(TvSeriesSearchLoaded(tvSeries)),
      );
    });
  }
}
