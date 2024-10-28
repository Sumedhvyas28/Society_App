import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

// not completed

class GuardAccessibilityPage extends StatefulWidget {
  const GuardAccessibilityPage({super.key});

  @override
  State<GuardAccessibilityPage> createState() => _GuardAccessibilityPageState();
}

class _GuardAccessibilityPageState extends State<GuardAccessibilityPage> {
  // State variables for the checkboxes
  bool isFirstCheckboxChecked = false;
  bool isSecondCheckboxChecked = false;
  String? _selectedReason;

  final List<String> duration = [
    '30 mins',
    '1 Hour',
    '2 Hour',
    '3 Hour',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: 'Guard Accessibility'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Visitor Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                          Text(
                            'Click Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.001),
                      Row(
                        children: [
                          Checkbox(
                            value: isFirstCheckboxChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isFirstCheckboxChecked = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Vendor',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Checkbox(
                            value: isSecondCheckboxChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isSecondCheckboxChecked = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Guest',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(201, 229, 229, 229),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color: Pallete.textBtnClr,
                                ),
                                Text(
                                  'Click',
                                  style: TextStyle(color: Pallete.textBtnClr),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Visitor Name',
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              filled: true,
                              focusColor: Pallete.greyBtnClr,
                              fillColor: Pallete.greyBtnClr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'Name of the visitor',
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
                            'Purpose of visit',
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
                              hintText: 'Delivering packages for the resident',
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
                                'Contact Number',
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expected Duration',
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.01),
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
                            hint: const Text('Duration Of the Visit'),
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
                              hintText: 'Any Other Relevant Information',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.01),
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
                            color: const Color.fromARGB(136, 230, 230, 230),
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
                          SizedBox(height: screenWidth * 0.01),
                          Container(
                            width: double.infinity,
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
