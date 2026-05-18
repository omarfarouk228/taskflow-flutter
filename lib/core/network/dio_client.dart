import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

part 'dio_client.g.dart';

const _baseUrl = 'https://api.taskflow.dev/v1';

@riverpod
Dio dioClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Client': 'TaskFlow-Flutter/1.0.0',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(dio),
    ErrorInterceptor(),
    if (kDebugMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        maxWidth: 120,
      ),
  ]);

  ref.onDispose(dio.close);
  return dio;
}
