import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  DateTime? _selectedDate;
  String isImageUploade = "";
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String? _base64Image;

  bool isDropdownDisabled = true;

  TextEditingController _reasonController = TextEditingController();
  TextEditingController _urgencyController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _additionalNotesController = TextEditingController();
  void initState() {
    super.initState();

    // Fetch visitor buildings on page load
    Provider.of<GuardFeatures>(context, listen: false).getGuardNamesApi();
  }

  var selectedValue;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final guardFeatures = Provider.of<GuardFeatures>(context);
    final guardMessageFeatures = Provider.of<MessageFeatures>(context);

    String? _selectedVisitorName;
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

    return Scaffold(
      appBar: CustomAppBar(title: 'Guard Messaging'),
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
                    'Guard name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenWidth * 0.04),
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
                          items: snapshot.data!.map((Data) {
                            return DropdownMenuItem<String>(
                              value: Data.toGuardId.toString(),
                              child: Text(Data.name ?? 'Unknown'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              print("value$value");

                              selectedValue = value!;
                              print(selectedValue);
                              // _selectedVisitorName = null;
                              print(_selectedVisitorName);
                            });
                            // print(selectedValue);
                          },
                        );
                      } else {
                        return Text('No buildings available');
                      }
                    },
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Text(
                    'Message/Reason to Contact: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  TextField(
                    controller: _reasonController,
                    decoration: InputDecoration(
                        hintText:
                            'Type your message or reason for communication',
                        filled: true,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Text(
                    'Urgency Level: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  TextField(
                    controller: _urgencyController,
                    decoration: InputDecoration(
                        hintText: 'Low/Medium/High',
                        filled: true,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Text(
                    'Category (If Any) ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                        filled: true,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
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
                  Text(
                    'Additional Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  TextField(
                    controller: _additionalNotesController,
                    decoration: InputDecoration(
                        hintText: 'Any other relevant information',
                        filled: true,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
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
                      onPressed: () async {
                        print(selectedValue);
                        final guardData = {
                          "to_guard_id": "$selectedValue",
                          "message": "${_reasonController.text}",
                          "urgency_level": "${_urgencyController.text}",
                          "category": "${_categoryController.text}",
                          "date": _selectedDate != null
                              ? _selectedDate!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]
                              : "",
                          "additional_notes":
                              "${_additionalNotesController.text}"
                        };

                        // Send the visitor data and attachment
                        await guardFeatures.postGuardMessageApi(
                            guardData, _imageFile);

                        if (guardFeatures.postError != null) {
                          print(guardData);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Error: ${guardFeatures.postError}')),
                          );
                        } else {
                          print(guardData);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
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
