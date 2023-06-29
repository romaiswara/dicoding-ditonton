// Mocks generated by Mockito 5.4.2 from annotations
// in tv_series/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:core/core.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:dio/dio.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i8;
import 'package:tv_series/data/data.dart' as _i3;
import 'package:tv_series/domain/domain.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvSeriesDetailModel_1 extends _i1.SmartFake
    implements _i3.TvSeriesDetailModel {
  _FakeTvSeriesDetailModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2<T> extends _i1.SmartFake implements _i4.Response<T> {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i5.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>
      getAiringTodayTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getAiringTodayTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i5.TvSeries>>(
              this,
              Invocation.method(
                #getAiringTodayTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>
      getOnTheAirTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getOnTheAirTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i5.TvSeries>>(
              this,
              Invocation.method(
                #getOnTheAirTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>
      getPopularTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getPopularTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i5.TvSeries>>(
              this,
              Invocation.method(
                #getPopularTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getTopRatedTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i5.TvSeries>>(
              this,
              Invocation.method(
                #getTopRatedTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>.value(
                _FakeEither_0<_i7.Failure, List<_i5.TvSeries>>(
          this,
          Invocation.method(
            #searchTvSeries,
            [query],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i5.TvSeriesDetail>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesDetail,
          [id],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i5.TvSeriesDetail>>.value(
                _FakeEither_0<_i7.Failure, _i5.TvSeriesDetail>(
          this,
          Invocation.method(
            #getTvSeriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i5.TvSeriesDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>
      getTvSeriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getTvSeriesRecommendations,
              [id],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i5.TvSeries>>(
              this,
              Invocation.method(
                #getTvSeriesRecommendations,
                [id],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlistTvSeries(
          Map<String, dynamic>? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlistTvSeries,
          [data],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlistTvSeries,
            [data],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlistTvSeries(
          int? tvSeriesId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTvSeries,
          [tvSeriesId],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Failure, String>>.value(
            _FakeEither_0<_i7.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlistTvSeries,
            [tvSeriesId],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlistTvSeries(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlistTvSeries,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistTvSeries,
              [],
            ),
            returnValue:
                _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>.value(
                    _FakeEither_0<_i7.Failure, List<_i5.TvSeries>>(
              this,
              Invocation.method(
                #getWatchlistTvSeries,
                [],
              ),
            )),
          ) as _i6.Future<_i2.Either<_i7.Failure, List<_i5.TvSeries>>>);
}

/// A class which mocks [TvSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRemoteDataSource extends _i1.Mock
    implements _i3.TvSeriesRemoteDataSource {
  MockTvSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i3.TvSeriesModel>> getAiringTodayTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAiringTodayTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i3.TvSeriesModel>>.value(<_i3.TvSeriesModel>[]),
      ) as _i6.Future<List<_i3.TvSeriesModel>>);
  @override
  _i6.Future<List<_i3.TvSeriesModel>> getOnTheAirTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getOnTheAirTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i3.TvSeriesModel>>.value(<_i3.TvSeriesModel>[]),
      ) as _i6.Future<List<_i3.TvSeriesModel>>);
  @override
  _i6.Future<List<_i3.TvSeriesModel>> getPopularTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i3.TvSeriesModel>>.value(<_i3.TvSeriesModel>[]),
      ) as _i6.Future<List<_i3.TvSeriesModel>>);
  @override
  _i6.Future<List<_i3.TvSeriesModel>> getTopRatedTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTvSeries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i3.TvSeriesModel>>.value(<_i3.TvSeriesModel>[]),
      ) as _i6.Future<List<_i3.TvSeriesModel>>);
  @override
  _i6.Future<List<_i3.TvSeriesModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvSeries,
          [query],
        ),
        returnValue:
            _i6.Future<List<_i3.TvSeriesModel>>.value(<_i3.TvSeriesModel>[]),
      ) as _i6.Future<List<_i3.TvSeriesModel>>);
  @override
  _i6.Future<_i3.TvSeriesDetailModel> getTvSeriesDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesDetail,
          [id],
        ),
        returnValue: _i6.Future<_i3.TvSeriesDetailModel>.value(
            _FakeTvSeriesDetailModel_1(
          this,
          Invocation.method(
            #getTvSeriesDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.TvSeriesDetailModel>);
  @override
  _i6.Future<List<_i3.TvSeriesModel>> getTvSeriesRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesRecommendations,
          [id],
        ),
        returnValue:
            _i6.Future<List<_i3.TvSeriesModel>>.value(<_i3.TvSeriesModel>[]),
      ) as _i6.Future<List<_i3.TvSeriesModel>>);
}

/// A class which mocks [TvSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesLocalDataSource extends _i1.Mock
    implements _i3.TvSeriesLocalDataSource {
  MockTvSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(Map<String, dynamic>? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [data],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(int? tvSeriesId) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [tvSeriesId],
        ),
        returnValue: _i6.Future<String>.value(''),
      ) as _i6.Future<String>);
  @override
  _i6.Future<_i3.TvSeriesTable?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesById,
          [id],
        ),
        returnValue: _i6.Future<_i3.TvSeriesTable?>.value(),
      ) as _i6.Future<_i3.TvSeriesTable?>);
  @override
  _i6.Future<List<_i3.TvSeriesTable>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue:
            _i6.Future<List<_i3.TvSeriesTable>>.value(<_i3.TvSeriesTable>[]),
      ) as _i6.Future<List<_i3.TvSeriesTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i7.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i8.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i6.Future<_i8.Database?>.value(),
      ) as _i6.Future<_i8.Database?>);
  @override
  _i6.Future<int> insertMovieWatchlist(Map<String, dynamic>? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertMovieWatchlist,
          [data],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<int> removeMovieWatchlist(int? movieId) => (super.noSuchMethod(
        Invocation.method(
          #removeMovieWatchlist,
          [movieId],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<int> insertTvSeriesWatchlist(Map<String, dynamic>? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertTvSeriesWatchlist,
          [data],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<int> removeTvSeriesWatchlist(int? tvSeriesId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeTvSeriesWatchlist,
          [tvSeriesId],
        ),
        returnValue: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvSeriesById,
          [id],
        ),
        returnValue: _i6.Future<Map<String, dynamic>?>.value(),
      ) as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistTvSeries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvSeries,
          [],
        ),
        returnValue: _i6.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [DioClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioClient extends _i1.Mock implements _i7.DioClient {
  MockDioClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response<dynamic>> get({
    required String? url,
    String? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {
            #url: url,
            #query: query,
          },
        ),
        returnValue:
            _i6.Future<_i4.Response<dynamic>>.value(_FakeResponse_2<dynamic>(
          this,
          Invocation.method(
            #get,
            [],
            {
              #url: url,
              #query: query,
            },
          ),
        )),
      ) as _i6.Future<_i4.Response<dynamic>>);
}