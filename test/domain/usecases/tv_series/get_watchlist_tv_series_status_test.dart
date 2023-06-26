import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTvSeriesStatus usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchListTvSeriesStatus(mockTvSeriesRepository);
  });

  final int dummyId = 31910;

  test('should get watchlist status from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchlistTvSeries(dummyId))
        .thenAnswer((_) async => true);

    // act
    final result = await usecase.execute(dummyId);

    // assert
    expect(result, true);
  });
}
