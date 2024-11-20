import 'dart:convert';

import 'package:society_app/models/guard/message/post_guard_message.dart';
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
}
