import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/post_visitor_dart.dart';
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

  bool isDropdownDisabled = true;

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final guardFeatures = Provider.of<GuardFeatures>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Guard Accessibility'),
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
                  VisitorTypeSection(
                    isFirstCheckboxChecked: false,
                    isSecondCheckboxChecked: false,
                    onFirstCheckboxChanged: (_) {},
                    onSecondCheckboxChanged: (_) {},
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Column(
                    children: [],
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  DropdownSection(
                    title: 'Society Member',
                    items: guardFeatures.visitorNames, // Dynamic visitor names
                    selectedValue: _selectedVisitorName,
                    onChanged: isDropdownDisabled
                        ? (_) {
                            setState(() {
                              _selectedVisitorName = 'fqfqfq';
                            });
                          }
                        : (value) {
                            setState(() {
                              _selectedVisitorName = value;
                            });
                          },
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
                    controller: societyMemberController,
                    title: 'Contact Number',
                    hintText: 'Enter your Contact Number',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: dateController,
                    title: 'Date',
                    hintText: 'Enter Date',
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
                      onPressed: () {
                        final visitorData = Data(
                          userName: "",
                          visitorType: 'Vendor',
                          visitorName: visitorNameController.text.toString(),
                          purposeOfVisit:
                              'Delivering packages for the resident',
                          contactNumber: '1234567890',
                          visitDate: '2024-11-06',
                          expectedDuration: '2 hours',
                          additionalNotes:
                              'Visitor is from ABC Courier Services',
                          status: 'Commented',
                          commentMessage:
                              'Please allow access only during working hours.',
                          apartmentNo: 'A-2',
                          address: '315 SHRI NAGAR EXT',
                        );

                        Provider.of<GuardFeatures>(context, listen: false)
                            .postVisitorApi(visitorData)
                            .then((_) {
                          print('s yes ');
                        }).onError(
                          (error, stackTrace) {
                            print('no');
                            error.toString();
                          },
                        );
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
}
