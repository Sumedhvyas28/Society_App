import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/visitor_details/visitor_details.dart';
import 'package:society_app/view_model/guard/guard_prop.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;

class VendorTypeVisitor extends StatefulWidget {
  const VendorTypeVisitor({super.key});

  @override
  State<VendorTypeVisitor> createState() => _VendorTypeVisitorState();
}

class _VendorTypeVisitorState extends State<VendorTypeVisitor> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GuardProp>(context, listen: false).getVisitorsDetailsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _searchController = TextEditingController();
    String _searchQuery = '';

    return Scaffold(
      appBar: CustomAppBar(title: 'Vendor Visitors'),
      backgroundColor: Pallete.mainDashColor,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          children: [
            // Searchable text field
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.trim().toLowerCase();
                  });
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search by name or status...',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.045,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<GuardProp>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return Center(
                      child: Text(
                        'Fetching data...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    );
                  }

                  if (viewModel.visitorDetails.isEmpty) {
                    return Center(
                      child: Text(
                        'No visitor details available.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    );
                  }

                  // Filter visitors based on the search query and visitor type
                  final filteredVisitors =
                      viewModel.visitorDetails.where((visitor) {
                    final typeMatch =
                        visitor.visitorType?.toLowerCase() == 'vendor';
                    final nameMatch = visitor.visitorName
                            ?.toLowerCase()
                            .contains(_searchQuery) ??
                        false;
                    final statusMatch =
                        visitor.status?.toLowerCase().contains(_searchQuery) ??
                            false;
                    return typeMatch && (nameMatch || statusMatch);
                  }).toList();

                  if (filteredVisitors.isEmpty) {
                    return Center(
                      child: Text(
                        'No matching vendors found.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    itemCount: filteredVisitors.length,
                    itemBuilder: (context, index) {
                      final visitor = filteredVisitors[index];
                      return ExpandableVisitorCard(visitor: visitor);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableVisitorCard extends StatefulWidget {
  final Data visitor; // Updated type to Data

  const ExpandableVisitorCard({Key? key, required this.visitor})
      : super(key: key);

  @override
  State<ExpandableVisitorCard> createState() => _ExpandableVisitorCardState();
}

class _ExpandableVisitorCardState extends State<ExpandableVisitorCard> {
  bool isExpanded = false;

  // Dropdown options
  final List<String> dropdownOptions = ['Approved', 'Rejected'];
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: screenWidth * 0.02,
        horizontal: screenWidth * 0.03,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.visitor.visitorName ?? 'Unknown Visitor',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Row(
                        children: [
                          Text(
                            widget.visitor.visitDate ?? 'N/A',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            widget.visitor.buildingName ?? 'N/A',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.visitor.visitorType ?? 'N/A',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedOption,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      hint: Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: screenWidth * 0.040,
                          color: Colors.orange,
                        ),
                      ),
                      items: dropdownOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) async {
                        setState(() {
                          selectedOption = newValue;
                        });

                        if (newValue != null) {
                          final TextEditingController commentController =
                              TextEditingController();

                          // Show dialog to collect optional comment
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Add Comment (Optional)"),
                                content: TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Enter your comment here (optional)",
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Proceed without comment
                                    },
                                    child: Text("Skip"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(commentController.text);
                                    },
                                    child: Text("Submit"),
                                  ),
                                ],
                              );
                            },
                          ).then((comment) async {
                            await _updateVisitorStatus(newValue, comment ?? "");
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Purpose: ${widget.visitor.purposeOfVisit ?? 'N/A'}',
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateVisitorStatus(String status, String comment) async {
    final url =
        'https://stagging.intouchsoftwaresolution.com/api/visitor-status/${widget.visitor.id}';

    final body = json.encode({
      'status': status,
      'comment_message': comment,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer ${GlobalData().token}",
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated successfully')),
        );
      } else {
        print(response.body);
        print(response);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update status')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
