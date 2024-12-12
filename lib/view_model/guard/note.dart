import 'dart:io';

import 'package:flutter/material.dart';
import 'package:society_app/models/guard/message/post_guard_note.dart';
import 'package:society_app/repository/guard_note.dart';

class GuardNoteViewModel extends ChangeNotifier {
  final GuardNoteRepository _repository = GuardNoteRepository();

  postGuardNote? noteResponse;

  Future<void> postGuardNoteApi(Data noteData, File imageFile) async {
    try {
      noteResponse = await _repository.postGuardNoteRepo(noteData, imageFile);
      notifyListeners();
    } catch (e) {
      print('Error posting guard note: $e');
    }
  }
}
