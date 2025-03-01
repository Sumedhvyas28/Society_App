import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/notification_services.dart';
import 'package:society_app/pages/gatekeeper_dashboard/edit_profile.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_noitification.dart';
import 'package:society_app/pages/gatekeeper_dashboard/more/more.dart';
import 'package:society_app/pages/gatekeeper_dashboard/sg_model.dart';
import 'package:society_app/view_model/guard/features.dart';
import 'package:society_app/view_model/user_session.dart';

class SecurityDashboardpage extends StatefulWidget {
  const SecurityDashboardpage({super.key});

  @override
  State<SecurityDashboardpage> createState() => _SecurityDashboardpageState();
}

class _SecurityDashboardpageState extends State<SecurityDashboardpage> {
  NotificationServices notificationServices = NotificationServices();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialTask();
  }

  void initialTask() async {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    await notificationServices.getDeviceToken().then(
      (value) {
        if (value != null) {
          Provider.of<GuardFeatures>(context, listen: false)
              .updateDeviceTokenApi(value);
          print(value);
        } else {
          print('Device token is null');
        }
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      body: Column(
        children: [
          const SizedBox(height: 50),
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
                        MaterialPageRoute(
                            builder: (context) => const EditProfilePage()),
                      );
                    },
                    icon: const Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
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
                    icon: const Icon(Icons.notifications,
                        color: Colors.black, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const GuardNoitificationIconPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert_outlined,
                        color: Colors.black, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MoreSection()),
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
                itemCount: gsGridItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => gsGridItems[index]['page']),
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
                            gsGridItems[index]['image'],
                            height: 100,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            gsGridItems[index]['title'],
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
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
