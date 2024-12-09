import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:society_app/models/device_token.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
import 'package:society_app/models/guard/userdetails/user_details.dart';
import 'package:society_app/models/guard/visitor_data.dart';
import 'package:society_app/models/guard/visitor_details/visitor_details.dart';
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:society_app/models/guard/societies.dart' as lol;

import 'package:http_parser/http_parser.dart';

class GuardRepo {
  final BaseApiServices _apiServices = NetworkApiService();

  List<Map<String, dynamic>> _notifications = [];
  List<Map<String, dynamic>> get notifications => _notifications;

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

  Future<bool> postVisitorDataGuard(
      Map<String, String> visitorData, File? imageFile) async {
    final headers = {
      "Authorization": "Bearer ${GlobalData().token}",
    };

    try {
      var uri = Uri.parse(AppUrl.postVisitorUrl);

      var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);

      // Add fields
      visitorData.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add file if exists
      if (imageFile != null) {
        print("Uploading file from path: ${imageFile.path}");
        var file = await http.MultipartFile.fromPath(
          'attachment',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      // Send the request
      var response = await request.send();

      // Handle the response
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 201) {
        print('Visitor data posted successfully: $responseBody');
        return true;
      } else {
        print('Failed to post visitor data: $responseBody');
        return false;
      }
    } catch (e) {
      print('Error posting visitor data: $e');
      throw Exception('Error posting visitor data');
    }
  }

  Future<bool> postGuardMessageData(
      Map<String, String> guardData, File? imageFile) async {
    final headers = {
      "Authorization": "Bearer ${GlobalData().token}",
      // Remove Content-Type here as it will be set automatically by MultipartRequest
    };

    try {
      var uri = Uri.parse(AppUrl.postGuardMessageUrl);

      // Create multipart request
      var request = http.MultipartRequest('POST', uri)..headers.addAll(headers);

      // Add visitor data fields to the request
      guardData.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add image file if present
      if (imageFile != null) {
        var file = await http.MultipartFile.fromPath('image', imageFile.path,
            contentType:
                MediaType('image', 'jpeg') // Update content type if needed
            );
        request.files.add(file);
      }

      // Send the request and get the response
      var response = await request.send();

      // Read the response body as a string
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print('Guard Message data posted successfully');
        return true;
      } else {
        // Print the actual error message from the response body
        print('Failed to post visitor data: $responseBody');
        return false;
      }
    } catch (e) {
      print('Error posting visitor data: $e');
      throw Exception('Error posting visitor data');
    }
  }

// make a repo here
  Future<getUserDetails> fetchUserDetails() async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        AppUrl.fetchUserDetails,
        headers,
      );

      if (response != null) {
        return getUserDetails.fromJson(response);
      } else {
        throw Exception("Failed to fetch user details.");
      }
    } catch (e) {
      throw Exception("Error fetching user details: $e");
    }
  }

  Future<lol.getSocieties> getSocietiesRepo() async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        AppUrl.getSocieties,
        headers,
      );

      if (response != null) {
        print('lfoflflfl');
        return lol.getSocieties.fromJson(response);
      } else {
        throw Exception("Failed to societues ser details.");
      }
    } catch (e) {
      throw Exception("Error fetching user details: $e");
    }
  }
}
