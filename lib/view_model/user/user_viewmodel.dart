import 'dart:io';

import 'package:flutter/material.dart';
import 'package:society_app/models/device_token.dart';
import 'package:society_app/models/guard/get_guard_names.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
import 'package:society_app/models/guard/userdetails/user_details.dart';
import 'package:society_app/models/guard/visitor_data.dart';
import 'package:society_app/models/guard/visitor_details/visitor_details.dart';
import 'package:society_app/repository/guard_repo.dart';
import 'package:society_app/repository/user_repo.dart';

class UserFeatures with ChangeNotifier {
  final UserModuleRepo _userModuleRepo = UserModuleRepo();
  bool isLoading = false; // Add this variable

  getUserDetails? _userDetails;

  getUserDetails? get userDetails => _userDetails;

  Future<void> postUserDetailsApi(Map<String, dynamic> updatedDetails) async {
    try {
      _userDetails = await _userModuleRepo.postUserDetailsRepo(updatedDetails);
      notifyListeners();
    } catch (e) {
      print("Error updating user details: $e");
    }
  }

  Future<void> getUserDetailsApi() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _userModuleRepo.fetchUserDetails();
      _userDetails = response; // Set the user details
      isLoading = false; // Set loading to false
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Error fetching user details: $e");
    }
  }
}
