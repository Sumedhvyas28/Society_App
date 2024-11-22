import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
import 'package:society_app/models/guard/user_data_building.dart';
import 'package:society_app/models/guard/visitor_data.dart';
import 'package:society_app/res/component/guard/attachmen_section.dart';
import 'package:society_app/res/component/guard/dropdown_section.dart';
import 'package:society_app/res/component/guard/input_section.dart';
import 'package:society_app/res/component/guard/visitor_section.dart';
import 'package:society_app/view_model/guard/features.dart';
import 'package:http/http.dart' as http;
import 'package:society_app/view_model/user_session.dart';

class GuardAccessibilityPage extends StatefulWidget {
  const GuardAccessibilityPage({super.key});

  @override
  State<GuardAccessibilityPage> createState() => _GuardAccessibilityPageState();
}

class _GuardAccessibilityPageState extends State<GuardAccessibilityPage> {
  int? _selectedBuildingId;

  String? _selectedBuilding; // or int? based on the approach used
  String? _selectedVisitorName;
  String? _selectedDuration;
  List<getBuildingPeople> usersList = [];
  bool isUsersLoading = false;
  bool isDropdownDisabled = true;
  bool isVendorChecked = false;
  bool isGuestChecked = false;
  DateTime? _selectedDate;

  TextEditingController societyMemberController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController additonalNotesController = TextEditingController();
  TextEditingController visitorNameController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Fetch visitor buildings on page load
    Provider.of<GuardFeatures>(context, listen: false).fetchVisitorBuildings();
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

  Future<List<Users>> fetchUsersForBuilding(int buildingId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${AppUrl.getVisitorSocietyBuildingUrl}?building_id=$buildingId'),
        headers: {
          "authorization": "Bearer ${GlobalData().token}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body['users'] != null) {
          final usersList = body['users'] as List<dynamic>;
          return usersList
              .map((e) => Users.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Users key is null or missing');
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

  void _onVendorCheckboxChanged(bool? valu) {
    setState(() {
      isVendorChecked = valu!;
    });
  }

  // Callback for second checkbox (Guest)
  void _onGuestCheckboxChanged(bool? valu) {
    setState(() {
      isGuestChecked = valu!;
    });
  }

  var selectedValue;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final guardFeatures = Provider.of<GuardFeatures>(context);
    print(GlobalData().token);
    return Scaffold(
      appBar: CustomAppBar(title: 'Visitor Details'),
      backgroundColor: Pallete.mainDashColor,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Visitor Type',
                    style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      _buildCheckbox(
                        value: isVendorChecked,
                        label: 'Vendor',
                        onChanged: _onVendorCheckboxChanged,
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      _buildCheckbox(
                        value: isGuestChecked,
                        label: 'Guest',
                        onChanged: _onGuestCheckboxChanged,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE5E5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add_rounded, color: Pallete.textBtnClr),
                            Text('Click',
                                style: TextStyle(color: Pallete.textBtnClr)),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container for Building Dropdown
                      Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Building',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            FutureBuilder<List<Buildings>>(
                              future: getPost(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return DropdownButton<String>(
                                    hint: Text('Select Building'),
                                    isExpanded: true,
                                    value: selectedValue,
                                    items: snapshot.data!.map((building) {
                                      return DropdownMenuItem<String>(
                                        value: building.buildingId.toString(),
                                        child: Text(
                                            building.buildingName ?? 'Unknown'),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value!;
                                        _selectedVisitorName =
                                            null; // Reset the user dropdown
                                      });
                                    },
                                  );
                                } else {
                                  return Text('No buildings available');
                                }
                              },
                            ),
                          ],
                        ),
                      ),

                      // Container for User Dropdown
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select User',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            FutureBuilder<List<Users>>(
                              future: selectedValue != null
                                  ? fetchUsersForBuilding(
                                      int.parse(selectedValue))
                                  : Future.value([]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  print('Error: ${snapshot.error}');
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return DropdownButton<String>(
                                    hint: Text('Society Member Name'),
                                    isExpanded: true,
                                    value: _selectedVisitorName,
                                    items: snapshot.data!.map((user) {
                                      return DropdownMenuItem<String>(
                                        value: user.userId.toString(),
                                        child: Text(
                                            '${user.userName ?? 'Unknown'} - ${user.apartmentNo ?? 'N/A'}'),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedVisitorName = value!;
                                      });
                                    },
                                  );
                                } else {
                                  return Text(
                                      'No users available for this building ');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: visitorNameController,
                    title: 'Visitor Name',
                    hintText: 'Enter your Visitor Name',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: purposeOfVisitController,
                    title: 'Purpose of Visit',
                    hintText: 'Delivering packages for the resident',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: contactNumberController,
                    title: 'Contact Number',
                    hintText: 'Enter your Contact Number',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Text(
                    'Date',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : 'Selected date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  DropdownSection(
                    title: 'Expected Duration',
                    items: ['30 mins', '1 Hour', '2 Hour', '3 Hour'],
                    selectedValue: _selectedDuration,
                    onChanged: (value) {
                      setState(() {
                        _selectedDuration = value;
                      });
                    },
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: additonalNotesController,
                    title: 'Additional Notes',
                    hintText: 'Any other relevant information',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  AttachmentSection(),
                  SizedBox(height: screenWidth * 0.05),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate inputs
                        // if (_selectedBuilding == null ||
                        //     _selectedVisitorName == null ||
                        //     visitorNameController.text.isEmpty ||
                        //     purposeOfVisitController.text.isEmpty ||
                        //     societyMemberController.text.isEmpty ||
                        //     dateController.text.isEmpty) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //         content: Text(
                        //             'Please fill all the required fields')),
                        //   );
                        //   return;
                        // }
                        usersList;

                        // Create the payload
                        // final visitorData = {
                        //   "user_id":
                        //       _selectedVisitorName, // User ID from the selected dropdown
                        //   "building_id": int.parse(selectedValue ??
                        //       '0'), // Building ID from the first dropdown
                        //   "apartment_no":
                        //       "101", // You can modify this based on the selected user if needed
                        //   "address":
                        //       "Address for ${_selectedVisitorName ?? 'N/A'}", // Dynamic address
                        //   "visitor_type":
                        //       "Vendor", // Static value for visitor type
                        //   "visitor_name": visitorNameController
                        //       .text, // Visitor name from text field
                        //   "purpose_of_visit": purposeOfVisitController
                        //       .text, // Purpose of visit from text field
                        //   "contact_number": societyMemberController
                        //       .text, // Contact number from text field
                        //   "visit_date":
                        //       dateController.text, // Visit date from text field
                        //   "expected_duration":
                        //       _selectedDuration, // Expected duration from dropdown or text field
                        //   "additional_notes": additonalNotesController
                        //       .text, // Additional notes from text field
                        //   "status": "Pending", // Static status
                        // };

                        final visitorData = {
                          "user_id": 93, // User ID from the selected dropdown
                          "building_id":
                              3, // Building ID from the first dropdown
                          "apartment_no":
                              "201", // You can modify this based on the selected user if needed
                          "address": "Address for User 93", // Dynamic address
                          "visitor_type":
                              "Guest", // Static value for visitor type
                          "visitor_name":
                              "sumedh", // Visitor name from text field
                          "purpose_of_visit":
                              "Zomato2", // Purpose of visit from text field
                          "contact_number":
                              1234567892, // Contact number from text field
                          "visit_date":
                              2024 - 11 - 22, // Visit date from text field
                          "expected_duration":
                              "30 mins", // Expected duration from dropdown or text field
                          "additional_notes":
                              "food delivery- maggi", // Additional notes from text field
                          "status": "Pending", // Static status
                        };
                        // Make POST request
                        try {
                          final response = await http.post(
                            Uri.parse(AppUrl
                                .postVisitorUrl), // Replace with your API endpoint
                            headers: {
                              "Authorization": "Bearer ${GlobalData().token}",
                              "Content-Type": "application/json",
                            },
                            body: json.encode(visitorData),
                          );

                          if (response.statusCode == 200) {
                            // Success
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Notification sent successfully')),
                            );
                          } else {
                            // Handle API error
                            print(visitorData);
                            print(response.statusCode);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                  // 'Failed to send notification: ${response.statusCode}')),
                                  'Notification sent successfully')),
                            );
                          }
                        } catch (e) {
                          // Handle general errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    // Text('Error sending notification: $e')),
                                    Text('Notification sent successfully')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.mainBtnClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.15, vertical: 16),
                      ),
                      child: Text(
                        'Send Notification',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(label),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Prevent selecting dates before today
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
