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
  bool _startTextAnimation = false;

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();

    _startAnimation();
  }

  void _startAnimation() {
    // Delay for 2 seconds to show the logo at the center
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _startTextAnimation = true;
      });
    });
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
    await Future.delayed(const Duration(seconds: 5));

    final isLoggedIn = await _authService.isLoggedIn();

    // context.go('/login');
    if (isLoggedIn) {
      context.go('/login');
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Logo remains at the center initially
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              left: _startTextAnimation
                  ? 50 // Moves left when text animation starts
                  : MediaQuery.of(context).size.width / 2 - 50,
              child: Image.asset(
                'assets/img/gs/splash.png', // Replace with your logo path
                width: 100,
              ),
            ),
            // Text slides in from the right
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              right: _startTextAnimation ? 100 : -200,
              child: Text(
                "Society Club", // Your text here
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
