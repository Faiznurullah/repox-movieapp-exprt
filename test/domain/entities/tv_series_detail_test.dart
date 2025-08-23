import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    episodeRunTime: [45],
    firstAirDate: '2020-01-01',
    genres: [Genre(id: 1, name: 'Drama')],
    homepage: '',
    id: 1,
    inProduction: false,
    languages: ['en'],
    lastAirDate: null,
    name: 'Test TV Series',
    numberOfEpisodes: 20,
    numberOfSeasons: 2,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Test TV Series',
    overview: 'Test overview',
    popularity: 8.0,
    posterPath: '/posterPath.jpg',
    status: 'Ended',
    tagline: 'Test tagline',
    type: 'Scripted',
    voteAverage: 8.0,
    voteCount: 100,
  );

  group('TvSeriesDetail Entity', () {
    test('should be a subclass of Equatable', () {
      // assert
      expect(tTvSeriesDetail, isA<Object>());
    });

    test('should have correct props', () {
      // assert
      expect(tTvSeriesDetail.props, [
        false,
        '/backdropPath.jpg',
        [45],
        '2020-01-01',
        [const Genre(id: 1, name: 'Drama')],
        '',
        1,
        false,
        ['en'],
        null,
        'Test TV Series',
        20,
        2,
        ['US'],
        'en',
        'Test TV Series',
        'Test overview',
        8.0,
        '/posterPath.jpg',
        'Ended',
        'Test tagline',
        'Scripted',
        8.0,
        100,
      ]);
    });
  });
}
