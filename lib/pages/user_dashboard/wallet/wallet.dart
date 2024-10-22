import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'wallet'),
      body: Center(
        child: Text('wallet'),
      ),
    );
  }
}
