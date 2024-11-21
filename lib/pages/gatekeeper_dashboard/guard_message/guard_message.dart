import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/get_guard_names.dart';
import 'package:society_app/res/component/guard/attachmen_section.dart';
import 'package:society_app/res/component/guard/dropdown_section.dart';
import 'package:society_app/res/component/guard/input_section.dart';
import 'package:society_app/view_model/guard/features.dart';
import 'package:society_app/view_model/guard/message.dart';
import 'package:http/http.dart' as http;
import 'package:society_app/view_model/user_session.dart';

class GuardMessagePage extends StatefulWidget {
  const GuardMessagePage({super.key});

  @override
  State<GuardMessagePage> createState() => _GuardMessagePageState();
}

class _GuardMessagePageState extends State<GuardMessagePage> {
  bool isFirstCheckboxChecked = false;
  bool isSecondCheckboxChecked = false;
  String? _selectedReason;

  String? _selectedBuilding;
  String? _selectedVisitorName;
  String? _selectedDuration;

  bool isDropdownDisabled = true;

  TextEditingController societyMemberController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController additonalNotesController = TextEditingController();
  TextEditingController visitorNameController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();
  void initState() {
    super.initState();

    // Fetch visitor buildings on page load
    Provider.of<GuardFeatures>(context, listen: false).getGuardNamesApi();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final guardFeatures = Provider.of<GuardFeatures>(context);
    final guardMessageFeatures = Provider.of<MessageFeatures>(context);

    String? _selectedVisitorName;

    Future<List<Data>> getPost() async {
      try {
        final response = await http.get(
          Uri.parse(AppUrl.getGuardNameUrl),
          headers: {
            "authorization": "Bearer ${GlobalData().token}",
            "Content-Type": "application/json",
          },
        );

        if (response.statusCode == 200) {
          final body = json.decode(response.body);

          // Log the response to inspect its structure
          print('Response Body: $body');

          // Check if 'data' or 'Data' exists and is a list
          if (body['data'] != null) {
            final guardList = body['data'] as List<dynamic>;
            return guardList.map((e) {
              return Data.fromJson(e as Map<String, dynamic>);
            }).toList();
          } else {
            throw Exception('Data key is null or missing');
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

    var selectedValue;

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
                  FutureBuilder<List<Data>>(
                    future: getPost(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return DropdownButton<String>(
                          hint: Text('Guard Name '),
                          isExpanded: true,
                          value: selectedValue,
                          items: snapshot.data!.map((Data data) {
                            return DropdownMenuItem<String>(
                              value: data.toGuardId,
                              child: Text(data.name.toString() ?? 'Unknown'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedValue = value!;
                            setState(() {});
                          },
                        );
                      } else {
                        return Text('No buildings available');
                      }
                    },
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: visitorNameController,
                    title: 'Message/Reason to Contact: ',
                    hintText: 'Type your message or reason for communication',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: purposeOfVisitController,
                    title: 'Urgency Level: ',
                    hintText: 'Low/Medium/High',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: societyMemberController,
                    title: 'Category (If Any) ',
                    hintText: 'Enter your Contact Number',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
                    controller: dateController,
                    title: 'Date',
                    hintText: 'Enter Date',
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
                        // final postMessageData = Data(
                        //   toGuardId: 98,
                        //   message: "Some visitor came looks suspicious",
                        //   urgencyLevel: "medium",
                        //   category: "reminder",
                        //   date: "2024-11-10",
                        //   additionalNotes: "Check in by 8:00 PM.",
                        //   attachment: null,
                        // );

                        // Provider.of<MessageFeatures>(context, listen: false)
                        //     .postGuardMessageApi(postMessageData)
                        //     .then((_) {
                        //   print('s yes ');
                        // }).onError(
                        //   (error, stackTrace) {
                        //     print('no');
                        //     error.toString();
                        //   },
                        // );
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
