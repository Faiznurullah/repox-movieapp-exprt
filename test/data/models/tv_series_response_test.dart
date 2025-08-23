import 'dart:convert';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/posterPath.jpg',
    firstAirDate: '2020-01-01',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTvSeriesResponse = TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('TvSeriesResponse', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/backdropPath.jpg",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/posterPath.jpg",
            "first_air_date": "2020-01-01",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1,
          }
        ],
      };

      // act
      final result = TvSeriesResponse.fromJson(jsonMap);

      // assert
      expect(result, tTvSeriesResponse);
    });

    test('should return a JSON map containing proper data', () async {
      // act
      final result = tTvSeriesResponse.toJson();

      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/backdropPath.jpg",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/posterPath.jpg",
            "first_air_date": "2020-01-01",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
