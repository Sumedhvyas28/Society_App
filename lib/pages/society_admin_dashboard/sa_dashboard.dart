import 'package:flutter/material.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/notification_services.dart';
import 'package:society_app/pages/society_admin_dashboard/more.dart';
import 'package:society_app/pages/society_admin_dashboard/notification.dart';
import 'package:society_app/pages/society_admin_dashboard/sa_edituser.dart';
import 'package:society_app/pages/society_admin_dashboard/sa_models.dart';
import 'package:society_app/view_model/user_session.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('device token');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          //seach bar
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SaEdituser()),
                      );
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: GlobalData().name,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationSAPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SaMore()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 60,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: saGridItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => saGridItems[index]['page']),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            saGridItems[index]['image'],
                            height: 100,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            saGridItems[index]['title'],
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
