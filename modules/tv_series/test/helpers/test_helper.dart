import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<DioClient>(as: #MockDioClient)
])
void main() {}
