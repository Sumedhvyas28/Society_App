import 'package:flutter/material.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/pages/gatekeeper_dashboard/sg_model.dart';

class SecurityDashboardpage extends StatefulWidget {
  const SecurityDashboardpage({super.key});

  @override
  State<SecurityDashboardpage> createState() => _SecurityDashboardpageState();
}

class _SecurityDashboardpageState extends State<SecurityDashboardpage> {
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
                  Icon(
                    Icons.person,
                    size: 35,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Manoj kumar',
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: Colors.black,
                      size: 40,
                    ),
                    onPressed: () {},
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
