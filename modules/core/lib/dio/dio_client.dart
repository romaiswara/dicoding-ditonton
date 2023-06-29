import 'dart:io';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioClient {
  DioClient._();

  static final DioClient _instance = DioClient._();

  static DioClient get instance => _instance;

  factory DioClient({SecurityContext? securityContext}) {
    if (securityContext != null) {
      _instance._dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final HttpClient client = HttpClient(context: securityContext);
          client.badCertificateCallback = (cert, host, port) => false;
          return client;
        },
      );
    }
    _instance._dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          try {
            print("onRequest: ${options.uri.toString()}");

            return handler.next(options);
          } catch (e) {
            print("onRequest error: $options");
            return handler.next(options);
          }
        },
        onResponse: (response, handler) {
          try {
            print(
                "onResponse status code: ${response.statusCode} - data: ${response.data}");
            return handler.next(response);
          } catch (e) {
            print("onResponse error: $response");
            return handler.next(response);
          }
        },
        onError: (DioException e, handler) {
          print("onError: $e");
          print("onError: ${e.response}");
          return handler.next(e);
        },
      ),
    );
    return _instance;
  }

  final Dio _dio = Dio();

  Future<Response> get({
    required String url,
    String? query,
  }) async {
    try {
      final Map<String, dynamic> params = {
        'api_key': apiKey,
      };

      if (query != null) {
        params['query'] = query;
      }

      final Response response = await _dio.get(
        baseUrl + url,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
