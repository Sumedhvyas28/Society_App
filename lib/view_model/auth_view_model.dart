import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:society_app/data/response/api_response.dart';
import 'package:society_app/models/user_data.dart';
import 'package:society_app/repository/auth_repo.dart';
import 'package:society_app/utils/utils.dart';
import 'package:society_app/view_model/get_main.dart';
import 'package:society_app/view_model/user_session.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool, value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool, value) {
    _signUpLoading = value;
    notifyListeners();
  }

  dynamic header = {
    HttpHeaders.authorizationHeader: 'Bearer ${GlobalData().token}'
  };

  dynamic header1 = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${GlobalData().token}'
  };

  // =========================================================================================

  ApiResponse<UserData> userData = ApiResponse.Loading();

  setUserData(ApiResponse<UserData> response) {
    userData = response;
    notifyListeners();
  }

  Future<void> getUserData() async {
    setUserData(ApiResponse.Loading());
    _myrepo.getUserDataRepo(header).then((value) {
      setUserData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserData(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  Future<void> loginRepo(dynamic data, BuildContext context) async {
    setLoading(bool, true);

    _myrepo.loginRepo(data).then((data1) async {
      print('Login Details $data1');

      if (data1['success'] == true) {
        // Extract user details from data1
        dynamic userData = {
          "token": data1['data']['token'].toString(),
          "name": data1['data']['name'].toString(),
          "role": data1['data']['role'].toString(),
        };

        // Store user data using Provider
        await Provider.of<UserSession>(context, listen: false)
            .storeUserData(userData);

        // Retrieve user role for navigation
        final role = await Provider.of<UserSession>(context, listen: false)
            .getUserRole();
        navigateTo(role!, context);

        // Display success message
        Utils.flushbarErrorMessage('User login successfully', context);
        print(authToken);
        print('token');

        setLoading(bool, false);

        // Navigate based on user role
      } else {
        setLoading(bool, false);

        Utils.flushbarErrorMessage('Invalid login response', context);
      }
    }).onError((error, stackTrace) {
      setLoading(bool, false);
      Utils.flushbarErrorMessage('Wrong Credentials', context);
      print('Error: $error');
    });
  }

  Future<void> registerUser(
      Map<String, dynamic> data, BuildContext context) async {
    setLoading(bool, true);

    try {
      final response = await _myrepo.registerRepo(data);

      // Check if response is successful
      if (response['success'] == true) {
        // Extract the user data from the 'data' key in the response
        var userData = response['data'];

        // Make sure that the response fields are not null before storing them
        String name = userData['name']?.toString() ?? 'Unknown';
        String email = userData['email']?.toString() ?? 'Unknown';
        String role = userData['role']?.toString() ?? 'Unknown';
        String token = userData['token']?.toString() ?? 'Unknown';

        // Debug output to ensure correct values are being extracted
        print('///');
        print(response);
        print('Name: $name');
        print('Email: $email');
        print('Role: $role');
        print('Token: $token');
        print('///');

        // Store user data in the session
        await Provider.of<UserSession>(context, listen: false).storeUserData({
          "name": name,
          "email": email,
          "role": role,
          "token": token,
        });

        // Show success message
        Utils.flushbarErrorMessage('Registration successful', context);
        print('User registered successfully');
        print('Role: $role');

        // Navigate based on role
        navigateTo(role, context);
      } else {
        Utils.flushbarErrorMessage('Registration failed', context);
      }
    } catch (e) {
      setLoading(bool, false);
      Utils.flushbarErrorMessage('Error: $e', context);
      print('Error during registration: $e');
    }

    setLoading(bool, false);
  }

  ///////////////////////
  void navigateTo(String role, BuildContext context) {
    print('Navigating based on role: $role');

    if (role == 'society_member') {
      GoRouter.of(context).go('/userdashboard');
    } else if (role == 'society_admin') {
      GoRouter.of(context).go('/societyadminpage');
    } else if (role == 'business_partner') {
      GoRouter.of(context).go('/bpdashboard');
    } else if (role == 'super_admin') {
      GoRouter.of(context).go('/superadmindashboard');
    } else if (role == 'vendor') {
      GoRouter.of(context).go('/vendorpage');
    } else if (role == 'security_guard') {
      GoRouter.of(context).go('/securitypage');
    } else {
      // Default case if the role doesn't match any expected values
      print('Role not matched, navigating to default');
      GoRouter.of(context).go('/defaultDashboard');
    }
  }
}
