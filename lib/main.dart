import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/navigation/app_navigation.dart';
import 'package:society_app/notification_services.dart';
import 'package:society_app/view_model/auth_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:society_app/view_model/guard/features.dart';
import 'package:society_app/view_model/guard/guard_prop.dart';
import 'package:society_app/view_model/guard/message.dart';
import 'package:society_app/view_model/guard/userProvider.dart';
import 'package:society_app/view_model/user/user_viewmodel.dart';
import 'package:society_app/view_model/user_session.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => App(),
  ));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserSession()),
        ChangeNotifierProvider(create: (_) => GuardFeatures()),
        ChangeNotifierProvider(create: (_) => MessageFeatures()),
        ChangeNotifierProvider(
          create: (_) => NotificationServices()..firebaseInit(context),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserFeatures()),
        ChangeNotifierProvider(create: (_) => GuardProp()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigation.router,
      ),
    );
  }
}
