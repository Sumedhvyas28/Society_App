import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/dummy/grid_items.dart';
import 'package:society_app/notification_services.dart';
import 'package:society_app/pages/user_dashboard/edit_profile.dart';
import 'package:society_app/pages/user_dashboard/modules/notification.dart';
import 'package:society_app/pages/user_dashboard/modules/more.dart';
import 'package:society_app/view_model/guard/features.dart';
import 'package:society_app/view_model/user_session.dart';

class DashbordPage extends StatefulWidget {
  const DashbordPage({super.key});

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  NotificationServices notificationServices = NotificationServices();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialTask();
  }

<<<<<<< HEAD
  void initialTask() async {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    await notificationServices.getDeviceToken().then(
=======
  void initialTask() {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then(
>>>>>>> 3e87260feea6e28e8fdec8edc919f2894c673490
      (value) {
        if (value != null) {
          Provider.of<GuardFeatures>(context, listen: false)
              .updateDeviceTokenApi(value);
          print(value);
<<<<<<< HEAD
=======
          print(GlobalData().token);
>>>>>>> 3e87260feea6e28e8fdec8edc919f2894c673490
        } else {
          print('Device token is null');
        }
      },
    );
<<<<<<< HEAD
    setState(() {
      isLoading = false;
    });
=======
>>>>>>> 3e87260feea6e28e8fdec8edc919f2894c673490
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
                        MaterialPageRoute(
                            builder: (context) => UserEditProfile()),
                      );
                    },
                    icon: Icon(
                      Icons.supervised_user_circle_rounded,
                      size: 40,
                    ),
                    color: Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: GlobalData().name,
                        hintStyle: TextStyle(
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
                            builder: (context) => NotificationPageUser()),
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
                        MaterialPageRoute(
                            builder: (context) => UserMoreSection()),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 60,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => gridItems[index]['page']),
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
                            gridItems[index]['image'],
                            height: 100,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            gridItems[index]['title'],
                            style: TextStyle(
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
