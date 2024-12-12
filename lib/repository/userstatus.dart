import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/view_model/user_session.dart';

import '../models/guard/note/noteDetails.dart';

class UserNoteRepository extends ChangeNotifier {
  Future<List<Data>> fetchNotes() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.getUserNote), // Ensure this is the correct API URL
        headers: {
          "authorization": "Bearer ${GlobalData().token}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        // Explicitly check and cast data
        if (body['success'] == true && body['data'] != null) {
          List<dynamic> dataList = body['data']; // Explicitly define the type
          return dataList
              .map((e) => Data.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Failed to fetch notes: ${body['message']}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Error fetching notes: $e');
    }
  }
}
