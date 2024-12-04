import 'package:society_app/pages/gatekeeper_dashboard/all_messages/all_message.dart';
import 'package:society_app/pages/gatekeeper_dashboard/all_messages/chat_page.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_accessibility.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_message/guard_message.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_notification/guard_notification.dart';
import 'package:society_app/pages/user_dashboard/modules/chat.dart';

final List<Map<String, dynamic>> gsGridItems = [
  {
    'image': 'assets/img/gs/guard.png',
    'title': 'Add Visitor Details',
    'page': GuardAccessibilityPage(),
  },
  {
    'image': 'assets/img/dashboard/directory/directory.png',
    'title': 'Vistor Details',
    'page': GuardNotificationPage(),
  },
  {
    'image': 'assets/img/gs/guardt.png',
    'title': 'Guard Messaging',
    'page': GuardMessagePage(),
  },
  {
    'image': 'assets/img/gs/message.png',
    'title': 'All Messages',
    'page': AllMessagePage(),
  },
  {
    'image': 'assets/img/gs/message.png',
    'title': 'Chat',
    'page': ChatPage(),
  },
];
