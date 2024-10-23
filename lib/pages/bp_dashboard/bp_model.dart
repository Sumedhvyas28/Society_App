import 'package:society_app/pages/user_dashboard/modules/Society_noti/society_notification.dart';
import 'package:society_app/pages/user_dashboard/modules/labour%20module/labour_page.dart';
import 'package:society_app/pages/user_dashboard/modules/shop%20module/shop_landing.dart';

final List<Map<String, dynamic>> bpGridItems = [
  {
    'image': 'assets/img/bp/coupon.png',
    'title': 'Coupon Module',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/bp/service.png',
    'title': 'Service Module',
    'page': LabourPage(),
  },
  {
    'image': 'assets/img/bp/job.png',
    'title': 'Job/Task Module',
    'page': SocietyNotificationPage(),
  },
];
