import 'package:society_app/pages/modules/Society_noti/society_notification.dart';
import 'package:society_app/pages/modules/amenity_booking/amenity.dart';
import 'package:society_app/pages/modules/labour%20module/labour_page.dart';
import 'package:society_app/pages/modules/shop%20module/shop_landing.dart';

final List<Map<String, dynamic>> saGridItems = [
  {
    'image': 'assets/img/dashboard/shop_module/shop_module.png',
    'title': 'Society Rule Book',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/labour/labour.png',
    'title': 'Employee Management',
    'page': LabourPage(),
  },
  {
    'image': 'assets/img/dashboard/notification/bell.png',
    'title': 'Budget & fianance',
    'page': SocietyNotificationPage(),
  },
  {
    'image': 'assets/img/dashboard/Amenity_booking/amenity.png',
    'title': 'Election Module',
    'page': AmenityPage(),
  },
  {
    'image': 'assets/img/dashboard/medical_module/medical.png',
    'title': 'Notification Module',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/security_service/security.png',
    'title': 'Security Gate Service ',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/tiffin_management/tiffin.png',
    'title': 'Amenity Module',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/rent_sale/list_sale.png',
    'title': 'Event Module',
    'page': ShopLanding(),
  },
];
