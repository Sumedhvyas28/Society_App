import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
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
import 'package:society_app/view_model/guard/userProvider.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class GuardAccessibilityPage extends StatefulWidget {
  const GuardAccessibilityPage({super.key});

  @override
  State<GuardAccessibilityPage> createState() => _GuardAccessibilityPageState();
}

class _GuardAccessibilityPageState extends State<GuardAccessibilityPage> {
  int? _selectedBuildingId;

  String? _selectedBuilding; // or int? based on the approach used
  String? _selectedVisitorName;
  String? _selectedVisitorAddress;
  String? _selectedDuration;
  List<getBuildingPeople> usersList = [];
  bool isUsersLoading = false;
  bool isDropdownDisabled = true;
  bool isVendorChecked = false;
  bool isGuestChecked = false;
  DateTime? _selectedDate;
  String isImageUploade = "";
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _base64Image;

  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _additonalNotesController =
      TextEditingController();
  final TextEditingController _visitorNameController = TextEditingController();
  final TextEditingController _purposeOfVisitController =
      TextEditingController();

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

  void _onVendorCheckboxChanged(bool? value) {
    setState(() {
      isVendorChecked = value ?? false;
      if (isVendorChecked) {
        isGuestChecked = false; // Uncheck Guest if Vendor is checked
      }
    });
  }

  void _onGuestCheckboxChanged(bool? value) {
    setState(() {
      isGuestChecked = value ?? false;
      if (isGuestChecked) {
        isVendorChecked = false; // Uncheck Vendor if Guest is checked
      }
    });
  }

  Future<void> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final name = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = '${directory.path}/$name.jpg';

      // Save the image to the file system
      final File storedImage = await File(image.path).copy(imagePath);

      setState(() {
        _imageFile = storedImage; // Store the image file
      });

      print("Image saved at: ${storedImage.path}");
    } else {
      print("No image selected.");
    }
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
                              // FutureBuilder<List<Buildings>>(
                              //   future: getPost(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       return Center(
                              //           child: CircularProgressIndicator());
                              //     } else if (snapshot.hasError) {
                              //       return Text('Error: ${snapshot.error}');
                              //     } else if (snapshot.hasData &&
                              //         snapshot.data!.isNotEmpty) {
                              //       return DropdownButton<String>(
                              //         hint: Text('Select Building'),
                              //         isExpanded: true,
                              //         value: selectedValue,
                              //         items: snapshot.data!.map((building) {
                              //           return DropdownMenuItem<String>(
                              //             value: building.buildingId.toString(),
                              //             child: Text(building.buildingName ??
                              //                 'Unknown'),
                              //           );
                              //         }).toList(),
                              //         onChanged: (value) {
                              //           setState(() {
                              //             // print("value$value");
                              //             selectedValue = value!;
                              //             print("sev $selectedValue");
                              //             _selectedVisitorName =
                              //                 null; // Reset the user dropdown
                              //             print(_selectedVisitorName);
                              //           });
                              //         },
                              //       );
                              //     } else {
                              //       return Text('No buildings available');
                              //     }
                              //   },
                              // ),
                              FutureBuilder<List<Buildings>>(
                                future: getPost(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return DropdownSearch<Buildings>(
                                      popupProps: PopupProps.menu(
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                            labelText: 'Search Building',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      asyncItems: (String? filter) async {
                                        // If filter is needed, implement logic here
                                        return snapshot.data ?? [];
                                      },
                                      itemAsString: (building) =>
                                          building.buildingName ?? 'Unknown',
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      selectedItem: snapshot.data?.firstWhere(
                                        (building) =>
                                            building.buildingId.toString() ==
                                            selectedValue,
                                        orElse: () => Buildings(
                                            buildingId: 0,
                                            buildingName: "Unknown"),
                                      ),
                                      onChanged: (Buildings? building) {
                                        setState(() {
                                          selectedValue =
                                              building?.buildingId.toString();
                                          _selectedVisitorName =
                                              null; // Reset dependent dropdown
                                        });
                                      },
                                    );
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
                                        final selectedUser = snapshot.data!
                                            .firstWhere((user) =>
                                                user.userId.toString() ==
                                                value);

                                        // Save user details using the provider
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .setUserDetails(
                                          selectedUser.userName ?? 'Unknown',
                                          selectedUser.apartmentNo ?? 'N/A',
                                          selectedUser.address ?? 'No address',
                                        );
                                        print(
                                            'Selected user details: ${selectedUser.address}');

                                        setState(() {
                                          _selectedVisitorName = value!;
                                        });
                                      },
                                    );
                                  } else {
                                    return Text(
                                        'No users available for this building');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    Text(
                      'Visitor Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    TextField(
                      controller: _visitorNameController,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Visitor Name',
                          filled: true,
                          focusColor: Colors.white,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    Text(
                      'Purpose of Visit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    TextField(
                      controller: _purposeOfVisitController,
                      decoration: InputDecoration(
                        hintText: 'Delivering packages for the resident',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    Text(
                      'Contact Number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    TextField(
                      controller: _contactNumberController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Contact Number',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                    Text(
                      'Additonal Note',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    TextField(
                      controller: _additonalNotesController,
                      decoration: InputDecoration(
                        hintText: 'Note',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          await _takePicture();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_circle_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text('Click a Picture'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.mainBtnClr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.15, vertical: 16),
                        ),
                        onPressed: () async {
                          print(
                              'Provider Address: ${Provider.of<UserProvider>(context, listen: false).address}');

                          print(_visitorNameController.text.trim());

                          // Prepare visitor data (excluding attachment)
                          final visitorData = {
                            "user_id": "$_selectedVisitorName",
                            "building_id": "$selectedValue",
                            "apartment_no": Provider.of<UserProvider>(context,
                                        listen: false)
                                    .apartmentNo ??
                                "",
                            "address": Provider.of<UserProvider>(context,
                                        listen: false)
                                    .address ??
                                "no address",
                            "visitor_type": isVendorChecked
                                ? "Vendor"
                                : (isGuestChecked ? "Guest" : "Unknown"),
                            "visitor_name": "${_visitorNameController.text}",
                            "purpose_of_visit":
                                "${_purposeOfVisitController.text.trim()}",
                            "contact_number":
                                "${_contactNumberController.text.trim()}",
                            "visit_date": _selectedDate != null
                                ? _selectedDate!
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0]
                                : "",
                            "expected_duration": _selectedDuration ?? "",
                            "additional_notes":
                                "${_additonalNotesController.text.trim()}"
                          };

                          // Send the visitor data and attachment
                          await guardFeatures.postVisitorNotification(
                              visitorData, _imageFile);

                          if (guardFeatures.postError != null) {
                            print(visitorData);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Error: ${guardFeatures.postError}')),
                            );
                          } else {
                            print(visitorData);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Notification sent successfully')),
                            );
                          }
                        },
                        child: guardFeatures.isPosting
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Send Notification',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ]),
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
