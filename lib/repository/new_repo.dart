import 'dart:convert';

import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/data/network/NetworkApiService.dart';
import 'package:society_app/data/network/baseApiService.dart';
import 'package:society_app/models/guard/visitor_details/visitor_details.dart';
import 'package:society_app/view_model/user_session.dart';

class NewRepository {
  NetworkApiService _apiServices = NetworkApiService();

  Future<List<Data>> getVisitorDetails() async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        AppUrl.getVisitorDetails,
        headers,
      );

      if (response != null && response['data'] != null) {
        return List<Data>.from(
            response['data'].map((data) => Data.fromJson(data)));
      } else {
        throw Exception('No data found for the selected building');
      }
    } catch (e) {
      throw Exception('Error fetching visitor details: $e');
    }
  }
}
