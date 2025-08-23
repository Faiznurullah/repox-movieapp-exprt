import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'Test TV Series',
    posterPath: '/posterPath.jpg',
    overview: 'Test overview',
  );

  const tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: null,
    episodeRunTime: [],
    firstAirDate: '',
    genres: [],
    homepage: '',
    id: 1,
    inProduction: false,
    languages: [],
    lastAirDate: null,
    name: 'Test TV Series',
    numberOfEpisodes: 0,
    numberOfSeasons: 0,
    originCountry: [],
    originalLanguage: '',
    originalName: '',
    overview: 'Test overview',
    popularity: 0,
    posterPath: '/posterPath.jpg',
    status: '',
    tagline: '',
    type: '',
    voteAverage: 0,
    voteCount: 0,
  );

  const tTvSeries = TvSeries.watchlist(
    id: 1,
    name: 'Test TV Series',
    posterPath: '/posterPath.jpg',
    overview: 'Test overview',
  );

  group('TvSeriesTable', () {
    test('should be a subclass of Equatable', () async {
      expect(tTvSeriesTable, isA<TvSeriesTable>());
    });

    test('should return a valid TvSeriesTable from TvSeriesDetail', () async {
      // act
      final result = TvSeriesTable.fromEntity(tTvSeriesDetail);
      
      // assert
      expect(result, tTvSeriesTable);
    });

    test('should return a valid TvSeries watchlist from TvSeriesTable', () async {
      // act
      final result = tTvSeriesTable.toEntity();
      
      // assert
      expect(result, tTvSeries);
    });

    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'name': 'Test TV Series',
        'posterPath': '/posterPath.jpg',
        'overview': 'Test overview',
      };

      // act
      final result = TvSeriesTable.fromMap(jsonMap);

      // assert
      expect(result, tTvSeriesTable);
    });

    test('should return a JSON map containing proper data', () async {
      // act
      final result = tTvSeriesTable.toJson();

      // assert
      final expectedJsonMap = {
        'id': 1,
        'name': 'Test TV Series',
        'posterPath': '/posterPath.jpg',
        'overview': 'Test overview',
      };
      expect(result, expectedJsonMap);
    });
  });
}
