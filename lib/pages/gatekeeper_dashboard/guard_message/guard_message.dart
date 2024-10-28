import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

class GuardMessagePage extends StatefulWidget {
  const GuardMessagePage({super.key});

  @override
  State<GuardMessagePage> createState() => _GuardMessagePageState();
}

class _GuardMessagePageState extends State<GuardMessagePage> {
  bool isFirstCheckboxChecked = false;
  bool isSecondCheckboxChecked = false;
  String? _selectedReason;

  final List<String> duration = [
    'Guard 1',
    'Guard 2',
    'Guard 3',
    'Guard 4',
    'Guard 5',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: 'Guard Messages'),
      backgroundColor: Pallete.mainDashColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Container(
            width: screenWidth,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guard to Connect',
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          DropdownButtonFormField<String>(
                            value: _selectedReason,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            hint: const Text('Select the guard '),
                            items: duration.map((String reason) {
                              return DropdownMenuItem<String>(
                                value: reason,
                                child: Text(reason),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedReason = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Message / Reason For Contact',
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Pallete.greyBtnClr,
                              focusColor: Pallete.greyBtnClr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              hintText:
                                  'Type your message or reason for communication',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Urgency Level',
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          TextField(
                            cursorColor:
                                const Color.fromARGB(255, 155, 155, 155),
                            maxLines: 1,
                            decoration: InputDecoration(
                              focusColor:
                                  const Color.fromARGB(255, 155, 155, 155),
                              fillColor:
                                  const Color.fromARGB(255, 155, 155, 155),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Low / Medium / High',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category (if any)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.02),
                              SizedBox(
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.4,
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.01),
                              SizedBox(
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.4,
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      SizedBox(height: screenWidth * 0.01),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Additional Notes',
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          TextField(
                            cursorColor:
                                const Color.fromARGB(255, 155, 155, 155),
                            maxLines: 1,
                            decoration: InputDecoration(
                              focusColor:
                                  const Color.fromARGB(255, 155, 155, 155),
                              fillColor:
                                  const Color.fromARGB(255, 155, 155, 155),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Any Other Relevant Information',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.03),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attachment (OPTIONAL) (FILE UPLOAD)',
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Container(
                            height: screenHeight * 0.05,
                            color: const Color.fromARGB(255, 224, 224, 224),
                            width: double.infinity,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_rounded,
                                    color: Pallete.mainDashColor,
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  Text(
                                    'Add Attachments',
                                    style:
                                        TextStyle(color: Pallete.mainDashColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.03),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Pallete.mainDashColor),
                                onPressed: () {},
                                child: Text(
                                  'Send Notification',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
