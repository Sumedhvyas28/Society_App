import 'dart:io';

import 'package:flutter/material.dart';
import 'package:society_app/models/device_token.dart';
import 'package:society_app/models/guard/message/get_message.dart';
import 'package:society_app/models/guard/visitor_details/visitor_details.dart';
import 'package:society_app/repository/new_repo.dart';

class GuardProp with ChangeNotifier {
  final NewRepository _repository = NewRepository();

  List<Data> visitorDetails = [];
  bool isLoading = false;

  Future<void> getVisitorsDetailsApi() async {
    isLoading = true;
    notifyListeners();
    try {
      visitorDetails = await _repository.getVisitorDetails();
    } catch (e) {
      debugPrint('Error fetching visitor details: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
