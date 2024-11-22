import 'package:society_app/pages/modules/Society_noti/society_notification.dart';
import 'package:society_app/pages/modules/labour%20module/labour_page.dart';
import 'package:society_app/pages/modules/shop%20module/shop_landing.dart';

final List<Map<String, dynamic>> superGridItems = [
  {
    'image': 'assets/img/super/settings.png',
    'title': 'Configuration',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/notification/bell.png',
    'title': 'Notification',
    'page': LabourPage(),
  },
  {
    'image': 'assets/img/super/request.png',
    'title': 'All Requests',
    'page': SocietyNotificationPage(),
  },
];
