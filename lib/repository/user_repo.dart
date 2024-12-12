import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:society_app/models/guard/message/post_guard_message.dart';
import 'package:society_app/models/guard/userdetails/user_details.dart';
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;

class UserModuleRepo with ChangeNotifier {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<getUserDetails> postUserDetailsRepo(Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}"
      };

      dynamic response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl
            .fetchUserDetails, // Replace with the correct endpoint for updates
        body,
        headers,
      );

      if (response != null) {
        print(body);
        print(response);
        return getUserDetails.fromJson(response);
      } else {
        throw Exception("Failed to update user details.");
      }
    } catch (e) {
      print(body);
      throw Exception("Error updating user details: $e");
    }
  }

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
}
