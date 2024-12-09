import 'package:dio/dio.dart';

import 'package:society_app/models/app_response.dart';
import 'package:society_app/models/requests/login_request.dart';
import 'package:society_app/models/requests/register_request.dart';
import 'package:society_app/repository/auth/base_repository.dart';
import 'package:society_app/repository/core/endpoints.dart';
import 'package:society_app/utils/dio_client/dio_client.dart';

import '../../models/user_model.dart';

class AuthRepository extends BaseRepository {
  AuthRepository({
    Dio? dioClient,
  }) : _dioClient = dioClient ?? DioClient().instance;

  final Dio _dioClient;

  @override
  Future<AppResponse<AuthUser?>> login(LoginRequest request) async {
    final response = await _dioClient.post(
      Endpoints.login,
      data: request.toJson(),
    );

    return AppResponse<AuthUser?>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? AuthUser.fromJson(json)
          : null,
    );
  }

  @override
  Future<AppResponse<AuthUser?>> loginWithToken() async {
    final response = await _dioClient.post(
      Endpoints.loginWithToken,
    );

    return AppResponse<AuthUser?>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? AuthUser.fromJson(json)
          : null,
    );
  }

  @override
  Future<AppResponse> logout() async {
    final response = await _dioClient.get(
      Endpoints.logout,
    );

    return AppResponse.fromJson(
      response.data,
      (dynamic json) => null,
    );
  }

  @override
  Future<AppResponse<AuthUser?>> register(RegisterRequest request) async {
    final response = await _dioClient.post(
      Endpoints.register,
      data: request.toJson(),
    );

    return AppResponse<AuthUser?>.fromJson(
      response.data,
      (dynamic json) => response.data['success'] && json != null
          ? AuthUser.fromJson(json)
          : null,
    );
  }
}
