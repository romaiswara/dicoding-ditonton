import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  const SeasonModel dummySeason = SeasonModel(
    airDate: '2023-01-01',
    episodeCount: 100,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: '/path.jpg',
    seasonNumber: 1,
  );

  final Map<String, dynamic> dummySeasonMap = {
    'air_date': '2023-01-01',
    'episode_count': 100,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': '/path.jpg',
    'season_number': 1,
  };

  test('should return a valid model from dummySeasonMap', () async {
    // act
    final result = SeasonModel.fromJson(dummySeasonMap);

    // assert
    expect(result, dummySeason);
  });

  test('should return map when call toJson()', () async {
    // act
    final result = dummySeason.toJson();

    // assert
    expect(result, dummySeasonMap);
  });
}
