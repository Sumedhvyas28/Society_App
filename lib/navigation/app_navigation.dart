import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:society_app/create_page.dart';
import 'package:society_app/homeBaseDashboard.dart';
import 'package:society_app/login_page.dart';
import 'package:society_app/pages/bp_dashboard/bp_dashboard.dart';
import 'package:society_app/pages/gatekeeper_dashboard/security_dashboard.dart';
import 'package:society_app/pages/society_admin_dashboard/sa_dashboard.dart';
import 'package:society_app/pages/super_admin_dashboard/super_dashboard.dart';
import 'package:society_app/pages/user_dashboard/coupon/coupon.dart';
import 'package:society_app/pages/user_dashboard/modules/dashbord.dart';
import 'package:society_app/pages/user_dashboard/my_unit/my_unit.dart';
import 'package:society_app/pages/user_dashboard/wallet/wallet.dart';
import 'package:society_app/pages/vendor_dashboard/vendor_dashboard.dart';
import 'package:society_app/starter_page.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/login';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>();
  static final _rootNavigatorMyUnit = GlobalKey<NavigatorState>();
  static final _rootNavigatorCoupon = GlobalKey<NavigatorState>();
  static final _rootNavigatorWallet = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return LoginPage(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/signup', // Update the path to be lowercase and without spaces
        name: 'SignUp', // Ensure consistency in the route name
        builder: (context, state) {
          return SignUpPage(
            key: state.pageKey,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return StarterPage(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          // Home / Dashboard
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: '/home',
                name: 'Home',
                builder: (context, state) {
                  return HomebasePage(
                    key: state.pageKey,
                  );
                },
              ),
              // user
              GoRoute(
                path: '/userdashboard',
                name: 'Userdashboard',
                builder: (context, state) {
                  return DashbordPage(
                    key: state.pageKey,
                  );
                },
              ),
              // super admin
              GoRoute(
                path: '/superadmindashboard',
                name: 'Superadmindashboard',
                builder: (context, state) {
                  return SuperDashboard(
                    key: state.pageKey,
                  );
                },
              ),
              // society admin
              GoRoute(
                path: '/societyadminpage',
                name: 'Societyadminpage',
                builder: (context, state) {
                  return AdminDashboardPage(
                    key: state.pageKey,
                  );
                },
              ),
              // bp page
              GoRoute(
                path: '/bpdashboard',
                name: 'Bpdashboard',
                builder: (context, state) {
                  return BpDashboardpage(
                    key: state.pageKey,
                  );
                },
              ),
              GoRoute(
                path: '/securitypage',
                name: 'SecurityPage',
                builder: (context, state) {
                  return SecurityDashboardpage(
                    key: state.pageKey,
                  );
                },
              ),
              GoRoute(
                path: '/vendorpage',
                name: 'Vendorpage',
                builder: (context, state) {
                  return VendorDashboardPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          // Leave
          StatefulShellBranch(
            navigatorKey: _rootNavigatorMyUnit,
            routes: [
              GoRoute(
                path: '/MyUnit',
                name: 'MyUnit',
                builder: (context, state) {
                  return MyUnitPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          // Profile
          StatefulShellBranch(
            navigatorKey: _rootNavigatorCoupon,
            routes: [
              GoRoute(
                path: '/Coupon',
                name: 'Coupon',
                builder: (context, state) {
                  return CouponPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorWallet,
            routes: [
              GoRoute(
                path: '/wallet',
                name: 'wallet',
                builder: (context, state) {
                  return WalletPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
