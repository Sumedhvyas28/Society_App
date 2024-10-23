import 'package:flutter/material.dart';

class SuperDashboard extends StatefulWidget {
  const SuperDashboard({super.key});

  @override
  State<SuperDashboard> createState() => _SuperDashboardState();
}

class _SuperDashboardState extends State<SuperDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('super admin'),
      ),
    );
  }
}
