import 'package:equatable/equatable.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTvSeries extends TvSeriesSearchEvent {
  final String query;

  const SearchTvSeries(this.query);

  @override
  List<Object> get props => [query];
}
