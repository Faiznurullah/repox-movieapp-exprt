import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv_series.dart';
import 'on_the_air_tv_series_event.dart';
import 'on_the_air_tv_series_state.dart';

class OnTheAirTvSeriesBloc extends Bloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState> {
  final GetOnTheAirTvSeries getOnTheAirTvSeries;

  OnTheAirTvSeriesBloc(this.getOnTheAirTvSeries) : super(OnTheAirTvSeriesEmpty()) {
    on<FetchOnTheAirTvSeries>((event, emit) async {
      emit(OnTheAirTvSeriesLoading());

      final result = await getOnTheAirTvSeries.execute();

      result.fold(
        (failure) => emit(OnTheAirTvSeriesError(failure.message)),
        (tvSeries) => emit(OnTheAirTvSeriesLoaded(tvSeries)),
      );
    });
  }
}
