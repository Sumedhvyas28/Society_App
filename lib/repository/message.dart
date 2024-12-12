import 'dart:convert';
import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:society_app/main.dart';
import 'package:society_app/models/guard/message/get_message.dart';
import 'package:society_app/models/guard/message/post_guard_message.dart';
import 'package:society_app/models/guard/note/noteDetails.dart' as note;
import 'package:society_app/network/BaseApiService.dart';
import 'package:society_app/network/NetworkApiService.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;

class GuardMessageRepo {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<postGuardMessage> postGuardMessageRepo(Data guardMessage) async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      final body = jsonEncode(guardMessage.toJson());

      final response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl.postGuardMessageUrl,
        body,
        headers,
      );

      if (response != null) {
        print(response['success']);
        print(response['message']);

        return postGuardMessage.fromJson(response);
      } else {
        throw Exception('Error: No response from the server');
      }
    } catch (e) {
      print(GlobalData().token);

      throw Exception('Error posting message details: $e');
    }
  }

  dynamic cleanData(dynamic json) {
    if (json is List) {
      return json.map((e) => cleanData(e)).toList();
    } else if (json is Map) {
      return json.map((key, value) {
        if (value is String && int.tryParse(value) != null) {
          return MapEntry(key, int.parse(value));
        }
        return MapEntry(key, cleanData(value));
      });
    }
    return json;
  }

  Future<List<GuardMessages>> fetchGuardMessages() async {
    try {
      Map<String, String> headers = {
        "authorization": "Bearer ${GlobalData().token}",
        "Content-Type": "application/json",
      };

      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
        AppUrl.postGuardMessageUrl,
        headers,
      );

      if (response != null && response['success'] == true) {
        List<dynamic> data = cleanData(response['data']);
        return data.map((e) => GuardMessages.fromJson(e)).toList();
      } else {
        print(response);
        throw Exception("Failed to fetch guard messages");
      }
    } catch (e) {
      throw Exception("Error fetching guard messages: $e");
    }
  }
}
