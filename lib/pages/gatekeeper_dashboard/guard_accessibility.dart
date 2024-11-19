import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/res/component/guard/attachmen_section.dart';
import 'package:society_app/res/component/guard/dropdown_section.dart';
import 'package:society_app/res/component/guard/input_section.dart';
import 'package:society_app/res/component/guard/send_notification.dart';
import 'package:society_app/res/component/guard/visitor_section.dart';
import 'package:society_app/view_model/guard/features.dart';

class GuardAccessibilityPage extends StatefulWidget {
  const GuardAccessibilityPage({super.key});

  @override
  State<GuardAccessibilityPage> createState() => _GuardAccessibilityPageState();
}

class _GuardAccessibilityPageState extends State<GuardAccessibilityPage> {
  String? _selectedBuilding;
  String? _selectedVisitorName;
  String? _selectedDuration;

  bool isDropdownDisabled = true;

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
                  DropdownSection(
                    title: 'Building',
                    items: guardFeatures.visitorBuildings, // Dynamic buildings
                    selectedValue: _selectedBuilding,
                    onChanged: (value) {
                      setState(() {
                        _selectedBuilding = value;
                        isDropdownDisabled = false;
                      });

                      // Fetch visitor names for the selected building
                      if (value != null) {
                        guardFeatures.fetchVisitorNames(value);
                      }
                    },
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  DropdownSection(
                    title: 'Visitor Name',
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
                    title: 'Contact Number',
                    hintText: 'Enter your Contact Number',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  InputSection(
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
                    title: 'Additional Notes',
                    hintText: 'Any other relevant information',
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  AttachmentSection(),
                  SizedBox(height: screenWidth * 0.05),
                  SizedBox(child: SendNotificationButton()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
