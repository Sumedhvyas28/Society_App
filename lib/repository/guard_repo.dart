import 'dart:convert';
import 'dart:io';

import 'package:society_app/models/device_token.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
import 'package:society_app/models/guard/visitor_data.dart';
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;

class GuardRepo {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<Buildings>> getBuilding() async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      final response = await http.get(
        Uri.parse(AppUrl.getVisitorSocietyUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);

        if (body.containsKey('buildings') && body['buildings'] is List) {
          final List buildingsList = body['buildings'];

          return buildingsList.map((e) {
            final map = e as Map<String, dynamic>;
            return Buildings(
              buildingId: map['building_id'],
              buildingName: map['building_name'],
            );
          }).toList();
        } else {
          throw Exception('Buildings data not found in response');
        }
      } else {
        throw Exception(
            'Failed to load buildings. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Error fetching buildings: $e');
    }
  }

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

      if (response != null) {
        // Parse response into your model
        visitorBuildingData buildingData =
            visitorBuildingData.fromJson(response);

        // Ensure buildings are not null and map them to building names
        if (buildingData.buildings != null) {
          return buildingData.buildings!
              .map((building) => building.buildingName ?? '')
              .toList();
        } else {
          throw Exception('No buildings data found');
        }
      } else {
        throw Exception('No response received from API');
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
        AppUrl.getVisitorSocietyBuildingUrl,
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
