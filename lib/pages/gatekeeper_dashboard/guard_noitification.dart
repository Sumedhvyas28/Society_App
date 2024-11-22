import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/notification_services.dart';
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
  final List<Map<String, dynamic>> mockNotifications = [
    {
      'title': 'Guard Notification',
      'body': 'Message from Guard 2: Suspicious person',
      'urgency_level': 'medium',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guard Notifications'),
      ),
      body: mockNotifications.isEmpty
          ? const Center(child: Text('No notifications yet'))
          : ListView.builder(
              itemCount: mockNotifications.length,
              itemBuilder: (context, index) {
                final notification = mockNotifications[index];

                // Extract data from the hard-coded notification
                final title = notification['title'] ?? 'No Title';
                final body = notification['body'] ?? 'No Body';
                final urgencyLevel = notification['urgency_level'] ?? 'normal';

                // Styling based on urgency level
                final color = urgencyLevel == 'high'
                    ? Colors.red
                    : urgencyLevel == 'medium'
                        ? Colors.orange
                        : Colors.green;

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: color,
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    subtitle: Text(body),
                    trailing: Text(
                      urgencyLevel.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
