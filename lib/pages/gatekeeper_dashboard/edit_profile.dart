import 'package:flutter/material.dart';
import 'package:society_app/constant/pallete.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.mainDashColor,
        title: Text('Back'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Pallete.mainDashColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/img/gs/userg.png'),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Guard 2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('A-103'),
                      ],
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit profile functionality
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Basic Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basic Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('+919009009001'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit phone number functionality
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('guard2@gmail.com'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit email functionality
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Add Year of Birth'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle add year of birth functionality
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.female),
                    title: Text('Add Gender'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle add gender functionality
                      },
                    ),
                  ),
                ],
              ),
            ),

            // More About You Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bit more about you',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.interests),
                    title: Text('Add Hobbies'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle add hobbies functionality
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('Add Job Title'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle add job title functionality
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Add Language'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle add language functionality
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Navigation Bar
            BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.my_location),
                  label: 'My Unit',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer),
                  label: 'Coupon',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wallet),
                  label: 'Wallet',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
