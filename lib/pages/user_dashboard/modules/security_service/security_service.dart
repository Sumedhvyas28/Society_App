import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/pages/user_dashboard/modules/shop%20module/shop_landing.dart';

class SecurityServicePage extends StatefulWidget {
  const SecurityServicePage({super.key});

  @override
  State<SecurityServicePage> createState() => _SecurityServicePageState();
}

class _SecurityServicePageState extends State<SecurityServicePage> {
  final List<Map<String, dynamic>> securityItems = [
    {
      'image': 'assets/img/dashboard/security_service/guest.png',
      'title': 'Guests/Visitor',
      'page': ShopLanding(),
      'description': 'Manage and track all guest entries effortlessly!'
    },
    {
      'image': 'assets/img/dashboard/security_service/cashback.png',
      'title': 'Vendors',
      'page': ShopLanding(),
      'description': 'Access a list of approved vendors for services!'
    },
    {
      'image': 'assets/img/dashboard/security_service/note.png',
      'title': 'Note Status',
      'page': ShopLanding(),
      'description': 'View and track details for all the deliveries.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Security Service'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: securityItems.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => securityItems[index]['page']),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 90,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                    child: Row(
                      children: [
                        // Image with proper height and width
                        Image.asset(
                          securityItems[index]['image'],
                          height: 50,
                          width: 50, // Adjusted width
                        ),
                        // Expanded to avoid overflow
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  securityItems[index]['title'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                                Text(
                                  securityItems[index]['description'],
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_right_alt),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
