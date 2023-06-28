import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  const GenreModel dummyGenre = GenreModel(
    id: 1,
    name: 'name',
  );

  final Map<String, dynamic> dummyGenreMap = {
    'id': 1,
    'name': 'name',
  };

  test('should return a valid model from dummyGenreMap', () async {
    // act
    final result = GenreModel.fromJson(dummyGenreMap);

    // assert
    expect(result, dummyGenre);
  });

  test('should return map when call toJson()', () async {
    // act
    final result = dummyGenre.toJson();

    // assert
    expect(result, dummyGenreMap);
  });
}
