import 'package:flutter/material.dart';
import 'package:society_app/repository/guard_repo.dart';

class GuardFeatures with ChangeNotifier {
  final GuardRepo _guardRepo = GuardRepo();

  List<String> visitorBuildings = [];
  List<String> visitorNames = [];

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
}
