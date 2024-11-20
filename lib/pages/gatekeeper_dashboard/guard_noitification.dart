import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/res/component/round_button.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:go_router/go_router.dart';

class GuardNoitificationIconPage extends StatefulWidget {
  const GuardNoitificationIconPage({super.key});

  @override
  State<GuardNoitificationIconPage> createState() =>
      _GuardNoitificationIconPageState();
}

class _GuardNoitificationIconPageState
    extends State<GuardNoitificationIconPage> {
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
