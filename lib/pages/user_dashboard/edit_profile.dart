import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/visitor_data.dart';
import 'package:society_app/view_model/guard/features.dart';
import 'package:society_app/view_model/user/user_viewmodel.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  var selectedValue;
  String? _selectedVisitorName;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserFeatures>(context, listen: false).getUserDetailsApi();
    });
  }

  Future<List<Buildings>> getPost() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.getVisitorSocietyUrl),
        headers: {
          "authorization": "Bearer ${GlobalData().token}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body['buildings'] != null) {
          final buildingsList = body['buildings'] as List<dynamic>;
          return buildingsList.map((e) {
            return Buildings.fromJson(e as Map<String, dynamic>);
          }).toList();
        } else {
          throw Exception('Buildings key is null or missing');
        }
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  void _showEditDialog(
      String title, String existingValue, Function(String) onSubmit) {
    final TextEditingController controller =
        TextEditingController(text: existingValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Edit $title',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current $title:',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                existingValue,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Enter new $title:',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4.0),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter new $title',
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Pallete.mainDashColor,
                  ),
                  onPressed: () async {
                    try {
                      // Submit the new value
                      await onSubmit(controller.text);

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .getUserDetailsApi();
                      });

                      // Refresh the UI
                      setState(() {});

                      // Close the dialog
                      Navigator.pop(context);
                    } catch (e) {
                      print("Error updating details: $e");
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<void>(
        future: Provider.of<UserFeatures>(context, listen: false)
            .getUserDetailsApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data.'));
          }

          final userDetails = Provider.of<UserFeatures>(context).userDetails;

          if (userDetails == null) {
            return const Center(child: Text('No user data available.'));
          }

          return SingleChildScrollView(
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
                          backgroundImage:
                              // userDetails
                              //             .data?.userDetail?.profileImage !=
                              //         null
                              //     ? NetworkImage(
                              //         userDetails.data!.userDetail!.profileImage!)
                              //     :
                              const AssetImage('assets/img/gs/userg.png')
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

                // User Details Section
                _buildSectionHeader('User Details'),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(userDetails.data?.user?.email ?? 'Add Email'),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(userDetails.data?.userDetail?.phoneNumber ??
                      'Add Phone Number'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Phone Number',
                      userDetails.data?.userDetail?.phoneNumber ?? '',
                      (newValue) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({"phone_number": newValue});
                      },
                    ),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.home),
                  title: Text(
                      userDetails.data?.userDetail?.address ?? 'Add Address'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Address',
                      userDetails.data?.userDetail?.address ?? '',
                      (newValue) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({"address": newValue});
                      },
                    ),
                  ),
                ),
                // ListTile(
                //   leading: const Icon(Icons.apartment),
                //   title: Text(
                //       userDetails.data?.userDetail?.buildingName?.toString() ??
                //           'Add Building Name ss'),
                //   trailing: IconButton(
                //     icon: const Icon(Icons.edit),
                //     onPressed: () => _showEditDialog(
                //       'Building Name',
                //       userDetails.data?.userDetail?.buildingName ??
                //           'Add Building Name',
                //       (newValue) {
                //         Provider.of<UserFeatures>(context, listen: false)
                //             .postUserDetailsApi({"building_id": newValue});
                //       },
                //     ),
                //   ),
                // ),

                FutureBuilder<List<Buildings>>(
                  future: getPost(), // Future to fetch buildings
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No buildings available');
                    } else {
                      final buildingsList = snapshot.data!;
                      final selectedBuilding = buildingsList.firstWhere(
                        (building) =>
                            building.buildingId.toString() == selectedValue,
                        orElse: () => buildingsList.first,
                      );

                      return StatefulBuilder(
                        // Wrap in StatefulBuilder to dynamically update UI
                        builder: (context, setState) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.house_outlined),
                                title: Text(
                                  selectedBuilding.buildingName ??
                                      'Select a Building',
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Icon(Icons.arrow_drop_down),
                                onTap: () async {
                                  final selected = await showDialog<Buildings>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  labelText: 'Search Building',
                                                  prefixIcon:
                                                      Icon(Icons.search),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  // Add a real-time search filter logic here if required
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: buildingsList.length,
                                                itemBuilder: (context, index) {
                                                  final building =
                                                      buildingsList[index];
                                                  return ListTile(
                                                    title: Text(
                                                        building.buildingName ??
                                                            'Unnamed'),
                                                    onTap: () {
                                                      Navigator.pop(
                                                          context, building);
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );

                                  if (selected != null) {
                                    setState(() {
                                      selectedValue =
                                          selected.buildingId.toString();
                                      _selectedVisitorName =
                                          null; // Reset dependent dropdown state
                                      // Trigger backend call to update building ID
                                      Provider.of<UserFeatures>(context,
                                              listen: false)
                                          .postUserDetailsApi(
                                        {"building_id": selectedValue},
                                      );
                                    });
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.house_outlined),
                  title: Text(userDetails.data?.userDetail?.apartmentNo ??
                      'Add Appartment No'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Building Name',
                      userDetails.data?.userDetail?.apartmentNo ??
                          'Add Building Name',
                      (newValue) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({"apartment_no": newValue});
                      },
                    ),
                  ),
                ),

                // Additional Details
                _buildSectionHeader('Additional Details'),
                ListTile(
                  leading: const Icon(Icons.cake),
                  title: Text(userDetails.data?.userDetail?.birthDate ??
                      'Add Birth Date'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Birth Date',
                      userDetails.data?.userDetail?.birthDate ??
                          'Add your birth Date',
                      (newValue) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({"birth_date": newValue});
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                      userDetails.data?.userDetail?.gender ?? 'Add Gender'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Gender',
                      userDetails.data?.userDetail?.gender ?? '',
                      (newValue) {
                        print(newValue);
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({'gender': newValue});
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person_3),
                  title: Text(userDetails.data?.userDetail?.age ?? 'Add age'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'age',
                      userDetails.data?.userDetail?.age ?? 'age',
                      (newValue) {
                        print(newValue);
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({'age': newValue});
                      },
                    ),
                  ),
                ),

                // Job and Hobbies Section
                _buildSectionHeader('Professional & Personal'),
                ListTile(
                  leading: const Icon(Icons.work),
                  title: Text(userDetails.data?.userDetail?.jobTitle ??
                      'Add Job Title'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Job Title',
                      userDetails.data?.userDetail?.jobTitle ?? 'No title',
                      (newValue) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({"job_title": newValue});
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.work),
                  title:
                      Text(userDetails.data?.userDetail?.hobbies ?? 'Hobbies'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Hobbies',
                      userDetails.data?.userDetail?.hobbies ?? 'No title',
                      (newValue) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({"hobbies": newValue});
                      },
                    ),
                  ),
                ),
                // ListTile(
                //   leading: const Icon(Icons.sports),
                //   title: Text(
                //       userDetails.data?.userDetail?.hobbies?.join(', ') ??
                //           'Add Hobbies'),
                //   trailing: IconButton(
                //     icon: const Icon(Icons.edit),
                //     onPressed: () => _showEditDialog(
                //       'hobbies',
                //       userDetails.data?.userDetail?.hobbies?.join(', ') ??
                //           'hobbies',
                //       (newValue) {
                //         Provider.of<UserFeatures>(context, listen: false)
                //             .postUserDetailsApi({"hobbies": newValue});
                //       },
                //     ),
                //   ),
                // ),

                // Languages Section
                _buildSectionHeader('Languages Spoken'),
                ListTile(
                  leading: const Icon(Icons.work),
                  title: Text(userDetails.data?.userDetail?.languagesSpoken ??
                      'Language Spoken'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(
                      'Language Spoken',
                      userDetails.data?.userDetail?.languagesSpoken ??
                          'Language Spoken',
                      (newValue) {
                        Provider.of<UserFeatures>(context, listen: false)
                            .postUserDetailsApi({"languages_spoken": newValue});
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
