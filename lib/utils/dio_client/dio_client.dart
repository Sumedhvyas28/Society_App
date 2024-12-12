import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  static DioClient? _singleton;

  static late Dio _dio;
  DioClient._() {
    _dio = createDioClient();
  }

  factory DioClient() {
    return _singleton ??= DioClient._();
  }

  Dio get instance => _dio;

  Dio createDioClient() {
    final dio = Dio(
      BaseOptions(
          baseUrl: "https://stagging.intouchsoftwaresolution.com/api/",
          receiveTimeout: Duration(seconds: 15),
          connectTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
          headers: {
            Headers.acceptHeader: 'application/json',
            Headers.contentTypeHeader: 'application/json',
          }),
    );

    dio.interceptors.addAll([]);
    return dio;
  }
}
