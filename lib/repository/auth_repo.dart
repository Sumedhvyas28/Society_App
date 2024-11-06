import 'dart:convert';

import 'package:society_app/constant/api_constants/api_headers.dart';
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';
import 'package:society_app/res/app_url.dart';

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
      // Convert the data to JSON if not already done in `getPostApiResponse`
      final response = await _apiServices.getPostApiWithHeaderResponse(
          AppUrl.loginUrl, jsonEncode(data), postHeader);

      return response;
    } catch (e) {
      print('❌❌❌ Login repo ----- $e');
      throw e;
    }
  }
}
