import 'package:society_app/models/app_response.dart';
import 'package:society_app/models/requests/register_request.dart';
import 'package:society_app/models/requests/request.dart';
import 'package:society_app/models/user_model.dart';

abstract class BaseRepository {
  Future<AppResponse<AuthUser?>> register(RegisterRequest request);
  Future<AppResponse<AuthUser?>> login(LoginRequest request);
  Future<AppResponse<AuthUser?>> loginWithToken();
  Future<AppResponse> logout();
}
