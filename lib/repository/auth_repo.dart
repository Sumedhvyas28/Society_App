import 'package:society_app/constant/api_constants/routes/api_routes.dart';
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> registerRepo(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      print('❌❌❌ Register Repo ----- $e');
      throw e;
    }
  }

  Future<dynamic> loginRepo(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      print('❌❌❌ Login repo ----- $e');
      throw e;
    }
  }
}
