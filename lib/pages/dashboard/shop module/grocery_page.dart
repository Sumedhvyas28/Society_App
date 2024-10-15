import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Grocery'),
      body: Center(
        child: Text('fqjqfjq'),
      ),
    );
  }
}
