import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String? _userName;
  String? _apartmentNo;
  String? _address;

  String? get userName => _userName;
  String? get apartmentNo => _apartmentNo;
  String? get address => _address;

  void setUserDetails(String userName, String apartmentNo, String address) {
    _userName = userName;
    _apartmentNo = apartmentNo;
    _address = address;
    notifyListeners();
  }

  void clearUserDetails() {
    _userName = null;
    _apartmentNo = null;
    _address = null;
    notifyListeners();
  }
}
