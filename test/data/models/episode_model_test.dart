import 'package:ditonton/data/models/episode_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final EpisodeModel dummyEpisode = EpisodeModel(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 9.5,
    voteCount: 10,
    airDate: '2023-01-01',
    episodeNumber: 100,
    productionCode: '',
    seasonNumber: 20,
    runtime: 25,
    stillPath: '/path.jpg',
  );

  final Map<String, dynamic> dummyEpisodeMap = {
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'vote_average': 9.5,
    'vote_count': 10,
    'air_date': '2023-01-01',
    'episode_number': 100,
    'production_code': '',
    'season_number': 20,
    'runtime': 25,
    'still_path': '/path.jpg',
  };

  test('should return a valid model from dummyEpisodeMap', () async {
    // act
    final result = EpisodeModel.fromJson(dummyEpisodeMap);

    // assert
    expect(result, dummyEpisode);
  });

  test('should return map when call toJson()', () async {
    // act
    final result = dummyEpisode.toJson();

    // assert
    expect(result, dummyEpisodeMap);
  });
}
