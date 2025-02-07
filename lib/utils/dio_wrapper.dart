import 'package:dio/dio.dart';

import '../data/user/user_repository.dart';

class DioWrapper {
  static DioWrapper? _instance;
  static Dio? _dio;

  factory DioWrapper() {
    return _instance ??= DioWrapper._internal();
  }

  DioWrapper._internal() {
    _instance = this;
  }

  Future<Dio> getDio() async {
    if (_dio == null) {
      final headers = {
        'Accept': 'application/json',
      };

      _dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout:
              const Duration(milliseconds: 30000), // Example of setting timeout
          headers: headers,
          baseUrl: 'https://ironingmaster.in/api/v1',
        ),
      );

      _dio?.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final authToken = await UserRepository().getApiAccessToken();
          if (authToken != null) {
            options.headers['Authorization'] = 'Bearer $authToken';
          }
          return handler.next(options);
        },
      ));

      _dio?.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
      ));
    }

    return _dio!;
  }
}
