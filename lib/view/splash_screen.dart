import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:society_app/view_model/user_session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserSession _authService = UserSession();

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> callNext() async {
    final role =
        await Provider.of<UserSession>(context, listen: false).getUserRole();

    if (kDebugMode) {
      print("Role is: $role");
    }

    // Use context.go to navigate based on role
    if (role == 'society_member') {
      context.go('/userdashboard');
    }
    // society admin
    else if (role == 'society_admin') {
      context.go('/societyadminpage');
    }
    // business partner
    else if (role == 'business_partner') {
      context.go('/bpdashboard');
    }

    // super admin
    else if (role == 'super_admin') {
      context.go('/superadmindashboard');
    }

    // vendor
    else if (role == 'vendor') {
      context.go('/vendorpage');
    }

    // security guard
    else if (role == 'security_guard') {
      context.go('/securitypage');
    } else {
      context.go('/defaultDashboard');
    }
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn = await _authService.isLoggedIn();

    if (isLoggedIn) {
      callNext();
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text('hello user splash'),
      ),
    );
  }
}
