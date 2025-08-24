import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailEmpty extends TvSeriesDetailState {}

class TvSeriesDetailLoading extends TvSeriesDetailState {}

class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;
  final List<TvSeries> tvSeriesRecommendations;
  final bool isAddedToWatchlist;

  const TvSeriesDetailLoaded({
    required this.tvSeriesDetail,
    required this.tvSeriesRecommendations,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object> get props => [tvSeriesDetail, tvSeriesRecommendations, isAddedToWatchlist];
}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  const TvSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}
