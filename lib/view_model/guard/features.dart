import 'dart:io';

import 'package:flutter/material.dart';
import 'package:society_app/models/device_token.dart';
import 'package:society_app/models/guard/get_guard_names.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
import 'package:society_app/models/guard/visitor_data.dart';
import 'package:society_app/repository/guard_repo.dart';

class GuardFeatures with ChangeNotifier {
  final GuardRepo _guardRepo = GuardRepo();

  bool _isPosting = false;
  String? _postError;

  bool get isPosting => _isPosting;
  String? get postError => _postError;

  List<String> visitorBuildings = [];
  List<String> visitorNames = [];
  postVisitorData? visitorResponse;
  List<String> guardsName = [];

  get visitorBuildingsdata => null;
  List<Buildings> _buildings = [];
  String? _selectedBuildingId;
  bool _isLoading = false;
  String? _errorMessage;

  List<Buildings> get buildings => _buildings;
  String? get selectedBuildingId => _selectedBuildingId;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBuildings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _buildings = await _guardRepo.getBuilding();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void selectBuilding(String? buildingId) {
    _selectedBuildingId = buildingId;
    notifyListeners();
  }

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
      print('Error fetching visitor buildings: $e');
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

  Future<void> updateDeviceTokenApi(String deviceToken) async {
    try {
      final response = await _guardRepo.postDeviceToken(deviceToken);
      print('Device token updated successfully');
      notifyListeners();
    } catch (e) {
      print('Error posting device token: $e');
    }
  }

  Future<void> postVisitorNotification(
      Map<String, String> visitorData, File? imageFile) async {
    _isPosting = true;
    _postError = null;
    notifyListeners();

    try {
      final isSuccess =
          await _guardRepo.postVisitorDataGuard(visitorData, imageFile);
      if (isSuccess) {
        print('Visitor notification posted successfully');
      } else {
        _postError = 'Failed to send visitor notification';
      }
    } catch (e) {
      _postError = e.toString();
    } finally {
      _isPosting = false;
      notifyListeners();
    }
  }
}
