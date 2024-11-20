import 'package:flutter/material.dart';
import 'package:society_app/models/guard/message/post_guard_message.dart';

import 'package:society_app/repository/message.dart';

class MessageFeatures with ChangeNotifier {
  final GuardMessageRepo _messageRepo = GuardMessageRepo();

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
}
