import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:society_app/repository/auth_repo.dart';
import 'package:society_app/utils/utils.dart';

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

  Future<void> loginRepo(dynamic data, BuildContext context) async {
    setLoading(bool, true);
    _myrepo.loginRepo(data).then((data1) {
      setLoading(bool, false);
      Utils.flushbarErrorMessage('login successfully', context);
      // var data = jsonDecode(datas.body.toString());
      print(data1);
      if (data1['success'] == true) {
        var token = data1['data']['token'];
        var role = data1['data']['name'];
        var message = data1['message'];

        print('Token: $token');
        print('Name: $role');
        print('Message: $message');

        // Navigate to the user dashboard based on the user's name

        // user
        if (role == 'Society Member'
            // && token == '63|B608exyr5lZ0Zmqg36jrkAcFOvuis3r2lnrTwGueec4e81eb'
            ) {
          GoRouter.of(context).go('/userdashboard');
        }

        //
        else if (role == 'Society admin') {
          GoRouter.of(context).go('/societyadminpage');
        }

        // bp
        else if (role == 'Business Partner') {
          GoRouter.of(context).go('/bpdashboard');
        }

        //super admin
        else if (role == 'super admin') {
          GoRouter.of(context).go('/superadmindashboard');
        }

        // vendor
        else if (role == 'Society Member') {
          GoRouter.of(context).go('/vendorpage');
        }

        // security page
        else if (role == 'Security Guard') {
          GoRouter.of(context).go('/securitypage');
        } else {
          // Default case if the user name does not match
          GoRouter.of(context).go('/defaultDashboard');
        }

        print('@L@##@@##@K');
        print(data1.toString());
      }
    }).onError(
      (error, stackTrace) {
        setLoading(bool, false);
        Utils.flushbarErrorMessage(error.toString(), context);
        print('fqnfqfqnfn');
      },
    );
  }

  Future<void> signRepo(dynamic data, BuildContext context) async {
    setSignUpLoading(bool, true);
    _myrepo.signUpRepo(data).then((data1) {
      setSignUpLoading(bool, false);
      Utils.flushbarErrorMessage('Sign Up successfully', context);
      // var data = jsonDecode(datas.body.toString());
      print(data1);
      if (data1['success'] == true) {
        var token = data1['data']['token'];
        var role = data1['data']['name'];
        var message = data1['message'];

        print('Token: $token');
        print('Name: $role');
        print('Message: $message');

        // Navigate to the user dashboard based on the user's name

        // user
        if (role == 'Society Member'
            // && token == '63|B608exyr5lZ0Zmqg36jrkAcFOvuis3r2lnrTwGueec4e81eb'
            ) {
          GoRouter.of(context).go('/userdashboard');
        }

        //
        else if (role == 'Society admin') {
          GoRouter.of(context).go('/societyadminpage');
        }

        // bp
        else if (role == 'Business Partner') {
          GoRouter.of(context).go('/bpdashboard');
        }

        //super admin
        else if (role == 'super admin') {
          GoRouter.of(context).go('/superadmindashboard');
        }

        // vendor
        else if (role == 'Society Member') {
          GoRouter.of(context).go('/vendorpage');
        }

        // security page
        else if (role == 'Security Guard') {
          GoRouter.of(context).go('/securitypage');
        } else {
          // Default case if the user name does not match
          GoRouter.of(context).go('/defaultDashboard');
        }

        print('@L@##@@##@K');
        print(data1.toString());
      }
    }).onError(
      (error, stackTrace) {
        setSignUpLoading(bool, false);
        Utils.flushbarErrorMessage(error.toString(), context);
        print('fqnfqfqnfn');
      },
    );
  }
}
