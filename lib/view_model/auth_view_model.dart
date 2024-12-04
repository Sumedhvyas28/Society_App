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
        navigateTo(role, context);

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

  Future<void> signUp(BuildContext context, dynamic data) async {
    setSignUpLoading(bool, true);

    _myrepo.signUpRepo(data).then((data1) async {
      print('Sign-Up Details $data1');

      if (data1['success'] == true) {
        // Extract user data from the response
        dynamic userData = {
          "token": data1['data']['token'],
          "name": data1['data']['name'],
          "email":
              data1['data']['email'] ?? '', // Email may or may not be provided
          "role": data1['data']['role'],
        };

        // Store user data in UserSession
        await Provider.of<UserSession>(context, listen: false)
            .storeUserData(userData);

        // Retrieve the user's role
        final role = await Provider.of<UserSession>(context, listen: false)
            .getUserRole();

        setSignUpLoading(bool, false);

        // Navigate based on role
        navigateTo(role, context);

        Utils.flushbarErrorMessage('Sign Up successfully', context);
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(bool, false);
      Utils.flushbarErrorMessage('Error: $error', context);
      print('Sign-Up Error: $error');
    });
  }

  ///////////////////////
  void navigateTo(role, context) {
    if (role == 'society_member'
        // && token == '63|B608exyr5lZ0Zmqg36jrkAcFOvuis3r2lnrTwGueec4e81eb'
        ) {
      GoRouter.of(context).go('/userdashboard');
    }

    //
    else if (role == 'society_admin') {
      GoRouter.of(context).go('/societyadminpage');
    }

    // bp
    else if (role == 'business_partner') {
      GoRouter.of(context).go('/bpdashboard');
    }

    //super admin
    else if (role == 'society_admin') {
      GoRouter.of(context).go('/superadmindashboard');
    }

    // vendor
    else if (role == 'vendor') {
      GoRouter.of(context).go('/vendorpage');
    }

    // security page
    else if (role == 'security_guard') {
      GoRouter.of(context).go('/securitypage');
    } else {
      // Default case if the user name does not match
      GoRouter.of(context).go('/defaultDashboard');
    }
  }
}
