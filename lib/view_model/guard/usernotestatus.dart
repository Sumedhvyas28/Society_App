import 'package:flutter/material.dart';
import 'package:society_app/repository/notestatus.dart';
import 'package:society_app/repository/userstatus.dart';

import '../../models/guard/note/noteDetails.dart';

class UserNoteViewModel with ChangeNotifier {
  final UserNoteRepository _noteUserRepository = UserNoteRepository();

  List<Data> _notes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Data> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notes = await _noteUserRepository.fetchNotes();
      _errorMessage = null;
    } catch (e) {
      _notes = [];
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
