import 'package:flutter/material.dart';
import 'package:society_app/pages/society_admin_dashboard/sa_dashboard.dart';
import 'package:society_app/pages/user_dashboard/modules/dashbord.dart'; // Ensure this import is correct

class HomebasePage extends StatefulWidget {
  const HomebasePage({super.key});

  @override
  State<HomebasePage> createState() => _HomebasePageState();
}

class _HomebasePageState extends State<HomebasePage> {
  @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Timer(const Duration(seconds: 3), () {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const DashbordPage()),
  //       );
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation (if needed)
            // SizedBox(
            //   height: 200,
            //   width: 200,
            //   child: Lottie.asset(
            //       'assets/animation/1.json'), // Replace with your Lottie animation file
            // ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DashbordPage()),
                );
              },
              child: const Text('Go to Dashboard'),
            ),
            const SizedBox(height: 20), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const AdminDashboardPage()), // Navigate to the random page
                );
              },
              child: const Text('Go to Random Page'),
            ),

            const SizedBox(height: 40),
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
