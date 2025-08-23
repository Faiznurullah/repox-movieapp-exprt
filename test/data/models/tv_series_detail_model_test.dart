import 'dart:convert';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  group('TvSeriesDetailResponse', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('dummy_data/tv_series_detail.json'),
      );

      // act
      final result = TvSeriesDetailResponse.fromJson(jsonMap);

      // assert
      expect(result, isA<TvSeriesDetailResponse>());
    });

    test('should return a JSON map containing proper data', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('dummy_data/tv_series_detail.json'),
      );
      final tvSeriesDetail = TvSeriesDetailResponse.fromJson(jsonMap);

      // act
      final result = tvSeriesDetail.toJson();

      // assert
      expect(result, isA<Map<String, dynamic>>());
    });
  });
}