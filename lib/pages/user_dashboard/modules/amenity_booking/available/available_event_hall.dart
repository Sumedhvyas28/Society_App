import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

class AvailableEventHallPage extends StatefulWidget {
  const AvailableEventHallPage({super.key});

  @override
  State<AvailableEventHallPage> createState() => _AvailableEventHallPageState();
}

class _AvailableEventHallPageState extends State<AvailableEventHallPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Event Hall'),
    );
  }
}
