import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';

class MyUnitPage extends StatefulWidget {
  const MyUnitPage({super.key});

  @override
  State<MyUnitPage> createState() => _MyUnitPageState();
}

class _MyUnitPageState extends State<MyUnitPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'My Unit'),
      body: Center(
        child: Text('my unit '),
      ),
    );
  }
}
