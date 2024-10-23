import 'package:society_app/pages/user_dashboard/modules/Society_noti/society_notification.dart';
import 'package:society_app/pages/user_dashboard/modules/amenity_booking/amenity.dart';
import 'package:society_app/pages/user_dashboard/modules/labour%20module/labour_page.dart';
import 'package:society_app/pages/user_dashboard/modules/shop%20module/shop_landing.dart';

final List<Map<String, dynamic>> gsGridItems = [
  {
    'image': 'assets/img/gs/guard.png',
    'title': 'Guard Accessibility',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/notification/bell.png',
    'title': 'Guard Notification',
    'page': LabourPage(),
  },
  {
    'image': 'assets/img/gs/guardt.png',
    'title': 'Guard Messages',
    'page': SocietyNotificationPage(),
  },
  {
    'image': 'assets/img/gs/message.png',
    'title': 'All Messages',
    'page': AmenityPage(),
  },
];
