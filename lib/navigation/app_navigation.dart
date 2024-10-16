import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:society_app/login_page.dart';
import 'package:society_app/pages/dashboard/dashbord.dart';
import 'package:society_app/pages/coupon/coupon.dart';
import 'package:society_app/pages/my_unit/my_unit.dart';
import 'package:society_app/pages/wallet/wallet.dart';
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
                  return DashbordPage(
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
