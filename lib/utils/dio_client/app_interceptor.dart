import 'dart:io';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  // Singleton instance
  static final AppInterceptors _singleton = AppInterceptors._internal();
  factory AppInterceptors() => _singleton;
  AppInterceptors._internal();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add Authorization header if not present
    if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
      const fakeToken = "FakeToken";
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $fakeToken';
    }

    handler.next(options); // Proceed with the request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Map custom response
    final responseData = mapResponseData(
      requestOptions: response.requestOptions,
      response: response,
    );

    handler.resolve(responseData); // Pass the response
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Get custom error message
    final errorMessage = getErrorMessage(err.type, err.response?.statusCode);

    // Map custom error response
    final responseData = mapResponseData(
      requestOptions: err.requestOptions,
      response: err.response,
      customMessage: errorMessage,
      isErrorResponse: true,
    );

    handler.resolve(responseData); // Resolve with custom error response
  }
}

// Function to get a user-friendly error message
String getErrorMessage(DioExceptionType errorType, int? statusCode) {
  switch (errorType) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return DioErrorMessage.deadlineExceededException;
    case DioExceptionType.badResponse:
      switch (statusCode) {
        case 400:
          return DioErrorMessage.badRequestException;
        case 401:
          return DioErrorMessage.unauthorizedException;
        case 404:
          return DioErrorMessage.notFoundException;
        case 409:
          return DioErrorMessage.conflictException;
        case 500:
          return DioErrorMessage.internalServerErrorException;
        default:
          return DioErrorMessage.unexpectedException;
      }
    case DioExceptionType.cancel:
      return "Request was cancelled.";
    case DioExceptionType.unknown:
      return DioErrorMessage.noInternetConnectionException;
    default:
      return DioErrorMessage.unexpectedException;
  }
}

// Class to hold common error messages
class DioErrorMessage {
  static const badRequestException = "Invalid request";
  static const internalServerErrorException =
      "Unknown error occurred, please try again later.";
  static const conflictException = "Conflict occurred";
  static const unauthorizedException = "Access denied";
  static const notFoundException =
      "The requested information could not be found";
  static const unexpectedException = "Unexpected error occurred.";
  static const noInternetConnectionException =
      "No internet connection detected, please try again.";
  static const deadlineExceededException =
      "The connection has timed out, please try again.";
}

// Function to map response data into a standard format
Response<dynamic> mapResponseData({
  Response<dynamic>? response,
  required RequestOptions requestOptions,
  String customMessage = "",
  bool isErrorResponse = false,
}) {
  final bool hasResponseData = response?.data != null;

  Map<String, dynamic>? responseData = response?.data as Map<String, dynamic>?;

  if (hasResponseData) {
    responseData!.addAll({
      "statusCode": response?.statusCode,
      "statusMessage": response?.statusMessage,
    });
  }

  return Response(
    requestOptions: requestOptions,
    data: hasResponseData
        ? responseData
        : {
            "message": customMessage,
            "success": !isErrorResponse,
            "statusCode": response?.statusCode,
            "statusMessage": response?.statusMessage,
          },
    statusCode: response?.statusCode,
    statusMessage: response?.statusMessage,
  );
}
