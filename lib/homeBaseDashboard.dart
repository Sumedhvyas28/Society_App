import 'dart:async'; // Import the Timer package
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Lottie for animations
import 'package:society_app/pages/user_dashboard/modules/dashbord.dart'; // Ensure this import is correct

class HomebasePage extends StatefulWidget {
  const HomebasePage({super.key});

  @override
  State<HomebasePage> createState() => _HomebasePageState();
}

class _HomebasePageState extends State<HomebasePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashbordPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your animation here (e.g., Lottie animation, GIF, etc.)
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                  'assets/animation/1.json'), // Replace with your Lottie animation file
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading Dashboard...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
