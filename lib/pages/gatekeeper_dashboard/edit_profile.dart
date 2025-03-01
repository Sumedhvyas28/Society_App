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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserDetails();
    });
  }

  void fetchUserDetails() async {
    await Provider.of<GuardFeatures>(context, listen: false)
        .getUserDetailsApi();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<GuardFeatures>(context).userDetails;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.mainDashColor,
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: userDetails == null
          ? const Center(child: Text('Failed to load user details'))
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
                    leading: const Icon(Icons.email),
                    title: Text(userDetails.data?.user?.email ?? 'Add Email'),
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
