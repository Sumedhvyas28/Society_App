import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // List to manage the state of switches
  final List<bool> _switchStates = [true, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Notification Settings'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: _NotificationSettingTile(
                title: 'Group Post',
                description:
                    'Get notified when replies are posted in your groups.',
                value: _switchStates[0],
                onChanged: (value) {
                  setState(() {
                    _switchStates[0] = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: _NotificationSettingTile(
                title: 'New Posts',
                description:
                    'Get notified when a New Conversation, Poll or Album is Created.',
                value: _switchStates[1],
                onChanged: (value) {
                  setState(() {
                    _switchStates[1] = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: _NotificationSettingTile(
                title: 'Response Posts',
                description:
                    'Get notified when replies are posted in General Conversation.',
                value: _switchStates[2],
                onChanged: (value) {
                  setState(() {
                    _switchStates[2] = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: _NotificationSettingTile(
                title: 'Know Your Society',
                description:
                    'Get updates on various usage tips / new features from Your Society App.',
                value: _switchStates[3],
                onChanged: (value) {
                  setState(() {
                    _switchStates[3] = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: _NotificationSettingTile(
                title: 'Buzzar',
                description:
                    'Whenever any listing is posted from the same community other residents get this app notification',
                value: _switchStates[4],
                onChanged: (value) {
                  setState(() {
                    _switchStates[4] = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationSettingTile extends StatelessWidget {
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationSettingTile({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(title),
      subtitle: Text(description),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
