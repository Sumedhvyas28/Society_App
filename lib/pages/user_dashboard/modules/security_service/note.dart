import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _formKey = GlobalKey<FormState>();
  final _noteNameController = TextEditingController();
  final _noteDescriptionController = TextEditingController();
  final _receiptController = TextEditingController();
  final _expectedTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  TextFormField(
                    controller: _receiptController,
                    decoration: InputDecoration(labelText: 'Receipt'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle adding attachments here
                    },
                    child: Text('Add Attachments'),
                  ),
                  TextFormField(
                    controller: _expectedTimeController,
                    decoration: InputDecoration(labelText: 'Expected Time'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle sending the request here
                        print('Note Name: ${_noteNameController.text}');
                        print(
                            'Note Description: ${_noteDescriptionController.text}');
                        print('Receipt: ${_receiptController.text}');
                        print('Expected Time: ${_expectedTimeController.text}');
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
