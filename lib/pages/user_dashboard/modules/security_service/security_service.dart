import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/pages/user_dashboard/modules/security_service/note.dart';
import 'package:society_app/pages/user_dashboard/modules/security_service/note_status.dart';
import 'package:society_app/pages/user_dashboard/modules/security_service/visitor.dart';
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
      'page': VisitorPage(),
      'description': 'Manage and track all guest entries effortlessly!'
    },
    {
      'image': 'assets/img/dashboard/security_service/cashback.png',
      'title': 'Note',
      'page': NotePage(),
      'description': 'Provdie A Note to Guard'
    },
    {
      'image': 'assets/img/dashboard/security_service/cashback.png',
      'title': 'Note Status',
      'page': NoteStatus(),
      'description': 'Check Status of Your note'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Visitor Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
              children: List.generate(securityItems.length, (index) {
            return _buildCard(context, index, securityItems[index]);
          })),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, index, dynamic item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => securityItems[index]['page']));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                securityItems[index]['image'],
                width: 60,
                height: 60,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      securityItems[index]['title'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      securityItems[index]['description'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
