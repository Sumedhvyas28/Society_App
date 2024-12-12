import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/api_constants/routes/app_url.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/get_guard_names.dart' as guardName;
import 'package:society_app/view_model/guard/features.dart';
import 'package:society_app/view_model/guard/message.dart';

import 'package:society_app/view_model/guard/note.dart' as guardModel;
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;

import '../../../../models/guard/message/post_guard_note.dart' as newG;

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers for form fields
  final _noteNameController = TextEditingController();
  final _noteDescriptionController = TextEditingController();
  final _receiptController =
      TextEditingController(); // Already added but unused
  final _expectedTimeController = TextEditingController();

  // Image Picker and selected file
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  // Selected value for dropdown
  var selectedValue;

  @override
  void dispose() {
    // Dispose of controllers when the widget is removed to free resources
    _noteNameController.dispose();
    _noteDescriptionController.dispose();
    _receiptController.dispose();
    _expectedTimeController.dispose();
    super.dispose();
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

  Future<List<guardName.Data>> getPost() async {
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

        print('Response Body: $body');

        if (body['data'] != null) {
          final guardList = body['data'] as List<dynamic>;
          return guardList.map((e) {
            return guardName.Data.fromJson(e as Map<String, dynamic>);
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

  @override
  Widget build(BuildContext context) {
    final guardFeatures = Provider.of<GuardFeatures>(context);
    final guardMessageFeatures = Provider.of<MessageFeatures>(context);
    final guardNoteViewModel =
        Provider.of<guardModel.GuardNoteViewModel>(context);

    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Note'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _noteNameController,
                    decoration: InputDecoration(labelText: 'Note Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a note name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _noteDescriptionController,
                    decoration: InputDecoration(labelText: 'Note Description'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a note description';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _takePicture,
                    child: Text('Add Attachments'),
                  ),
                  FutureBuilder<List<guardName.Data>>(
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
                          hint: Text('Guard Name'),
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
                              selectedValue = value!;
                            });
                          },
                        );
                      } else {
                        return Text('No guards available');
                      }
                    },
                  ),
                  TextFormField(
                    controller: _expectedTimeController,
                    decoration: InputDecoration(labelText: 'Expected Time'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _imageFile != null) {
                        final data = newG.Data(
                            name: _noteNameController.text,
                            description: _noteDescriptionController.text,
                            time: _expectedTimeController.text,
                            guard: selectedValue);
                        print(data.name);
                        print(data.guard);
                        print(data.name);
                        print(data.name);

                        try {
                          await guardNoteViewModel.postGuardNoteApi(
                              data, _imageFile!);
                          if (guardNoteViewModel.noteResponse != null) {
                            print(
                                'Response: ${guardNoteViewModel.noteResponse!.message}');
                          }
                        } catch (e) {
                          print('Failed to submit guard note: $e');
                        }
                      } else {
                        print('Validation failed or no image selected.');
                      }
                    },
                    child: Text('Send Request'),
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
