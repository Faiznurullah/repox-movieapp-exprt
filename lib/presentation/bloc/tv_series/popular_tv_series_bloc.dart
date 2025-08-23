import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'popular_tv_series_event.dart';
import 'popular_tv_series_state.dart';

class PopularTvSeriesBloc extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc(this.getPopularTvSeries) : super(PopularTvSeriesEmpty()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(PopularTvSeriesLoading());

      final result = await getPopularTvSeries.execute();

      result.fold(
        (failure) => emit(PopularTvSeriesError(failure.message)),
        (tvSeries) => emit(PopularTvSeriesLoaded(tvSeries)),
      );
    });
  }
}
