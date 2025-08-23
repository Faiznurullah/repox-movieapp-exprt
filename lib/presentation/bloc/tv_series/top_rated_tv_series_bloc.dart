import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'top_rated_tv_series_event.dart';
import 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this.getTopRatedTvSeries) : super(TopRatedTvSeriesEmpty()) {
    on<FetchTopRatedTvSeries>((event, emit) async {
      emit(TopRatedTvSeriesLoading());

      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (failure) => emit(TopRatedTvSeriesError(failure.message)),
        (tvSeries) => emit(TopRatedTvSeriesLoaded(tvSeries)),
      );
    });
  }
}
