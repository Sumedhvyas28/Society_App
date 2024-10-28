import 'package:society_app/pages/gatekeeper_dashboard/all_messages/all_message.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_accessibility.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_message/guard_message.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_notification/guard_notification.dart';

final List<Map<String, dynamic>> gsGridItems = [
  {
    'image': 'assets/img/gs/guard.png',
    'title': 'Guard Accessibility',
    'page': GuardAccessibilityPage(),
  },
  {
    'image': 'assets/img/dashboard/notification/bell.png',
    'title': 'Guard Notification',
    'page': GuardNotificationPage(),
  },
  {
    'image': 'assets/img/gs/guardt.png',
    'title': 'Guard Messages',
    'page': GuardMessagePage(),
  },
  {
    'image': 'assets/img/gs/message.png',
    'title': 'All Messages',
    'page': AllMessagePage(),
  },
];
