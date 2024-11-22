import 'package:society_app/pages/modules/Society_noti/society_notification.dart';
import 'package:society_app/pages/modules/labour%20module/labour_page.dart';
import 'package:society_app/pages/modules/shop%20module/shop_landing.dart';

final List<Map<String, dynamic>> vendorGridItems = [
  {
    'image': 'assets/img/super/settings.png',
    'title': 'Coupon Module',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/notification/bell.png',
    'title': 'Service Module',
    'page': LabourPage(),
  },
  {
    'image': 'assets/img/bp/job.png',
    'title': 'Job/Task Module',
    'page': SocietyNotificationPage(),
  },
];
