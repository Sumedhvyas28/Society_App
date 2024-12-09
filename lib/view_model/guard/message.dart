import 'package:flutter/material.dart';
import 'package:society_app/models/guard/message/get_message.dart';
import 'package:society_app/models/guard/message/post_guard_message.dart';

import 'package:society_app/repository/message.dart';

class MessageFeatures with ChangeNotifier {
  final GuardMessageRepo _messageRepo = GuardMessageRepo();
  bool isLoading = false;

  postGuardMessage? messageDataResponse;

  Future<void> postGuardMessageApi(Data messageData) async {
    try {
      messageDataResponse =
          await _messageRepo.postGuardMessageRepo(messageData);
      print('fqkfkkqkqfkfqkfq yes');
      notifyListeners();
    } catch (e) {
      print('Error posting visitor details: $e');
    }
  }

  List<GuardMessages> guardMessages = [];

  // Fetch guard messages and update the UI
  Future<void> getGuardMessages() async {
    isLoading = true;
    notifyListeners();

    try {
      guardMessages = await _messageRepo.fetchGuardMessages();
    } catch (e) {
      debugPrint('Error fetching guard messages: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
