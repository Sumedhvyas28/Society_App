import 'package:flutter/material.dart';
import 'package:society_app/models/device_token.dart';
import 'package:society_app/models/guard/get_guard_names.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
import 'package:society_app/repository/guard_repo.dart';

class GuardFeatures with ChangeNotifier {
  final GuardRepo _guardRepo = GuardRepo();

  List<String> visitorBuildings = [];
  List<String> visitorNames = [];
  postVisitorData? visitorResponse;
  List<String> guardsName = [];

  Future<void> getGuardNamesApi() async {
    try {
      guardsName = await _guardRepo.getGuardName();
      print('success');
      notifyListeners();
    } catch (e) {
      print('Error fetching new API data: $e');
    }
  }

  // Fetch building data
  Future<void> fetchVisitorBuildings() async {
    try {
      visitorBuildings = await _guardRepo.getVisitorSocietyData();
      notifyListeners();
    } catch (e) {
      print('Error fetching buildings: $e');
    }
  }

  // Fetch visitor names for a selected building
  Future<void> fetchVisitorNames(String building) async {
    try {
      visitorNames = await _guardRepo.getVisitorNames(building);
      notifyListeners();
    } catch (e) {
      print('Error fetching visitor names: $e');
    }
  }

  // add here postvisitapi

  Future<void> postVisitorApi(Data visitorData) async {
    try {
      visitorResponse = await _guardRepo.postVisitorDetails(visitorData);
      print('fqkfkkqkqfkfqkfq yes');
      notifyListeners();
    } catch (e) {
      print('Error posting visitor details: $e');
    }
  }

  Future<void> updateDeviceTokenApi(String deviceToken) async {
    try {
      final response = await _guardRepo.postDeviceToken(deviceToken);
      print('Device token updated successfully');
      notifyListeners();
    } catch (e) {
      print('Error posting device token: $e');
    }
  }
}
