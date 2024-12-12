import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/res/component/round_button.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:go_router/go_router.dart';

class VendorMorePage extends StatefulWidget {
  const VendorMorePage({super.key});

  @override
  State<VendorMorePage> createState() => VendorMorePageState();
}

class VendorMorePageState extends State<VendorMorePage> {
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserSession>(context, listen: false);

    return Scaffold(
      body: Center(
        child: RoundButton(
          title: 'Logout',
          onPressed: () async {
            await userPreference.signOut().then((value) {
              context.go('/login');
            });
          },
        ),
      ),
    );
  }
}
