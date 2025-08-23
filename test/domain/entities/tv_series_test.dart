import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TvSeries entity', () async {
    expect(tTvSeries, isA<TvSeries>());
  });

  test('should have correct props', () async {
    expect(tTvSeries.props, [
      false, // adult
      'backdropPath',
      [1, 2, 3], // genreIds
      1, // id
      ['US'], // originCountry
      'en', // originalLanguage
      'originalName',
      'overview',
      1, // popularity
      'posterPath',
      'firstAirDate',
      'name',
      1, // voteAverage
      1, // voteCount
    ]);
  });

  test('should create watchlist TvSeries correctly', () async {
    final watchlistTvSeries = TvSeries.watchlist(
      id: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      name: 'name',
    );

    expect(watchlistTvSeries.id, 1);
    expect(watchlistTvSeries.overview, 'overview');
    expect(watchlistTvSeries.posterPath, 'posterPath');
    expect(watchlistTvSeries.name, 'name');
  });
}
