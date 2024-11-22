import 'package:society_app/pages/modules/labour%20module/labour_page.dart';
import 'package:society_app/pages/modules/shop%20module/shop_landing.dart';

final List<Map<String, dynamic>> bpGridItems = [
  {
    'image': 'assets/img/bp/coupon.png',
    'title': 'Coupon Module',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/bp/manage.png',
    'title': 'Manage Order',
    'page': LabourPage(),
  },
];
