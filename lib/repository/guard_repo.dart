import 'dart:convert';

import 'package:society_app/models/device_token.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/view_model/user_session.dart';

class GuardRepo {
  final BaseApiServices _apiServices = NetworkApiService();

  // change in this
  Future<List<String>> getGuardName() async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        AppUrl.getGuardNameUrl,
        headers,
      );

      if (response != null && response['data'] != null) {
        print(GlobalData().token);
        return List<String>.from(response['data']);
      } else {
        throw Exception('No data found from new API');
      }
    } catch (e) {
      throw Exception('Error fetching buildings: $e');
    }
  }

  // Fetch building data
  Future<List<String>> getVisitorSocietyData() async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        AppUrl.getVisitorSocietyUrl,
        headers,
      );

      if (response != null && response['buildings'] != null) {
        print(GlobalData().token);
        return List<String>.from(response['buildings']);
      } else {
        throw Exception('No buildings data found');
      }
    } catch (e) {
      throw Exception('Error fetching buildings: $e');
    }
  }

  // Fetch visitors for the selected building
  Future<List<String>> getVisitorNames(String building) async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        '${AppUrl.getVisitorSocietyBuildingUrl}?building=$building',
        headers,
      );

      if (response != null && response['users'] != null) {
        print(response.body);
        return List<String>.from(
          response['users'].map((user) => user['name'].toString()),
        );
      } else {
        print(building);
        throw Exception('No users found for the selected building');
      }
    } catch (e) {
      throw Exception('Error fetching visitor names: $e');
    }
  }

  // Post visitor details API
  Future<postVisitorData> postVisitorDetails(Data visitorData) async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      final body = jsonEncode(visitorData.toJson());

      final response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl.postVisitorUrl,
        body,
        headers,
      );

      if (response != null) {
        print(response['success']);
        print(response['message']);

        return postVisitorData.fromJson(response);
      } else {
        throw Exception('Error: No response from the server');
      }
    } catch (e) {
      print(GlobalData().token);
      throw Exception('Error posting visitor details: $e');
    }
  }

  Future<postVisitorData> postDeviceToken(String deviceToken) async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      // Wrap deviceToken in a JSON object
      final body = jsonEncode({"device_token": deviceToken});

      final response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl.updateDeviceTokenUrl,
        body,
        headers,
      );

      print('Device token sent: $deviceToken');

      if (response != null) {
        print(response['success']);
        print(response['message']);

        return postVisitorData.fromJson(response);
      } else {
        throw Exception('Error: No response from the server');
      }
    } catch (e) {
      print(GlobalData().token);
      throw Exception('Error posting device token: $e');
    }
  }
}
