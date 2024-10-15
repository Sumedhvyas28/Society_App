import 'package:flutter/material.dart';

class HousemaidPage extends StatefulWidget {
  const HousemaidPage({super.key});

  @override
  State<HousemaidPage> createState() => _HousemaidPageState();
}

class _HousemaidPageState extends State<HousemaidPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('housemaid'),
      ),
    );
  }
}
