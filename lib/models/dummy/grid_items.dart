import 'package:society_app/pages/modules/Society_noti/society_notification.dart';
import 'package:society_app/pages/modules/amenity_booking/amenity.dart';
import 'package:society_app/pages/modules/labour%20module/labour_page.dart';
import 'package:society_app/pages/modules/shop%20module/shop_landing.dart';

final List<Map<String, dynamic>> gridItems = [
  {
    'image': 'assets/img/dashboard/shop_module/shop_module.png',
    'title': 'Shop Module',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/labour/labour.png',
    'title': 'Labour Module',
    'page': LabourPage(),
  },
  {
    'image': 'assets/img/dashboard/notification/bell.png',
    'title': 'Society Notification',
    'page': SocietyNotificationPage(),
  },
  {
    'image': 'assets/img/dashboard/Amenity_booking/amenity.png',
    'title': 'Amenity Booking',
    'page': AmenityPage(),
  },
  {
    'image': 'assets/img/dashboard/medical_module/medical.png',
    'title': 'Medical Module',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/security_service/security.png',
    'title': 'Security Service ',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/tiffin_management/tiffin.png',
    'title': 'Tiffin Management',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/rent_sale/list_sale.png',
    'title': 'Flat for Rent/Sale',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/sale_household/sale_household.png',
    'title': 'Sale Household Item',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/directory/directory.png',
    'title': 'Directory',
    'page': ShopLanding(),
  },
  {
    'image': 'assets/img/dashboard/gallery/gallery.png',
    'title': 'Gallery',
    'page': ShopLanding(),
  },
];
