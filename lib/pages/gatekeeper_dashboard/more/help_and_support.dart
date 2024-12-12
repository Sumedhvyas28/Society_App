import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Help & Support',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.green,
            dividerColor: Colors.grey,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'FAQ'),
              Tab(
                text: 'Contact Us',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _FAQScreen(),
            _ContactUsScreen(),
          ],
        ),
      ),
    );
  }
}

class _FAQScreen extends StatelessWidget {
  const _FAQScreen();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExpansionTile(
          title: Text('How do I manage my notifications?'),
          children: [
            ListTile(
              title: Text(
                  'To manage notifications, go to "Settings", select "Notification Settings," and customize your preferences.'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('How do I join support group?'),
          children: [
            ListTile(
              title: Text('To start a guided meditation session...'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('How do I start a guided meditation session?'),
          children: [
            ListTile(
              title: Text('To start a guided meditation session...'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Is my data safe and private? '),
          children: [
            ListTile(
              title: Text('To start a guided meditation session...'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactUsScreen extends StatelessWidget {
  const _ContactUsScreen();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Card(
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              leading: Icon(
                Icons.headset,
                color: Pallete.mainBtnClr,
              ),
              title: Text(
                'Customer Services',
                style: TextStyle(
                  color: Pallete.mainBtnClr,
                ),
              ),
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          Card(
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              leading: Icon(
                Icons.message,
                color: Pallete.mainBtnClr,
              ),
              title: Text(
                'WhatsApp',
                style: TextStyle(
                  color: Pallete.mainBtnClr,
                ),
              ),
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          Card(
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              leading: Icon(
                Icons.public,
                color: Pallete.mainBtnClr,
              ),
              title: Text(
                'Website',
                style: TextStyle(
                  color: Pallete.mainBtnClr,
                ),
              ),
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          Card(
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              leading: Icon(
                Icons.facebook,
                color: Pallete.mainBtnClr,
              ),
              title: Text(
                'Facebook',
                style: TextStyle(
                  color: Pallete.mainBtnClr,
                ),
              ),
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          Card(
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              leading: Icon(
                Icons.chat,
                color: Pallete.mainBtnClr,
              ),
              title: Text(
                'Twitter',
                style: TextStyle(
                  color: Pallete.mainBtnClr,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
