import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/view_model/guard/features.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GuardFeatures>(context, listen: false).getUserDetailsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<GuardFeatures>(context).userDetails;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.mainDashColor,
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: userDetails == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Container(
                    color: Pallete.mainDashColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: userDetails
                                        .data?.userDetail?.profileImage !=
                                    null
                                ? NetworkImage(
                                    userDetails.data!.userDetail!.profileImage!)
                                : const AssetImage('assets/img/gs/userg.png')
                                    as ImageProvider,
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userDetails.data?.user?.name ?? 'No Name',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(userDetails.data?.userDetail?.societyName ??
                                  'No Society Name'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Basic Profile Section
                  _buildSectionHeader('Basic Profile'),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(userDetails.data?.userDetail?.phoneNumber ??
                        'Add Phone Number'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(userDetails.data?.user?.email ?? 'Add Email'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(userDetails.data?.userDetail?.birthDate ??
                        'Add Birth Date'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.female),
                    title: Text(
                        userDetails.data?.userDetail?.gender ?? 'Add Gender'),
                  ),

                  // More About You Section
                  _buildSectionHeader('Bit More About You'),
                  ListTile(
                    leading: const Icon(Icons.interests),
                    title: Text(
                        userDetails.data?.userDetail?.hobbies ?? 'Add Hobbies'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.work),
                    title: Text(userDetails.data?.userDetail?.jobTitle ??
                        'Add Job Title'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(userDetails.data?.userDetail?.languagesSpoken ??
                        'Add Language'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
