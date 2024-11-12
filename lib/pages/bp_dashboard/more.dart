import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:society_app/res/component/round_button.dart';
import 'package:society_app/view_model/user_session.dart';

class bpMoreSection extends StatelessWidget {
  const bpMoreSection({super.key});

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
