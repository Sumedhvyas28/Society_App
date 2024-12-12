import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';

class TermsAndPrivacy extends StatefulWidget {
  const TermsAndPrivacy({super.key});

  @override
  State<TermsAndPrivacy> createState() => _TermsAndPrivacyState();
}

class _TermsAndPrivacyState extends State<TermsAndPrivacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Terms & Privacy'),
    );
  }
}
