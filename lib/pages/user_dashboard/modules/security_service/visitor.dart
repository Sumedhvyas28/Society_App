import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/visitor_details/visitor_details.dart';
import 'package:society_app/view_model/guard/guard_prop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:society_app/view_model/user_session.dart';
// Existing imports...
import 'package:provider/provider.dart';

class VisitorPage extends StatefulWidget {
  const VisitorPage({super.key});

  @override
  State<VisitorPage> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GuardProp>(context, listen: false).getVisitorsDetailsApi();
    });
  }

  void _refreshVisitorList() {
    Provider.of<GuardProp>(context, listen: false).getVisitorsDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _searchController = TextEditingController();
    String _searchQuery = '';

    return Scaffold(
      appBar: CustomAppBar(title: 'Guests'),
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

                  // Filter visitors based on the search query
                  final filteredVisitors = viewModel.visitorDetails
                      .where((visitor) =>
                          (visitor.visitorName
                                  ?.toLowerCase()
                                  .contains(_searchQuery) ??
                              false) ||
                          (visitor.status
                                  ?.toLowerCase()
                                  .contains(_searchQuery) ??
                              false))
                      .toList();

                  if (filteredVisitors.isEmpty) {
                    return Center(
                      child: Text(
                        'No matching visitors found.',
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
                      return ExpandableVisitorCard(
                        visitor: visitor,
                        onStatusUpdated: _refreshVisitorList,
                      );
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
  final Data visitor;
  final VoidCallback onStatusUpdated;

  const ExpandableVisitorCard({
    Key? key,
    required this.visitor,
    required this.onStatusUpdated,
  }) : super(key: key);

  @override
  State<ExpandableVisitorCard> createState() => _ExpandableVisitorCardState();
}

class _ExpandableVisitorCardState extends State<ExpandableVisitorCard> {
  bool isExpanded = false;

  final List<String> dropdownOptions = ['Approved', 'Rejected'];
  String? selectedOption;

  bool get isStatusFinalized => widget.visitor.status != 'Pending';

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
                    ],
                  ),
                  const Spacer(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: isStatusFinalized ? widget.visitor.status : null,
                      hint: Text(
                        isStatusFinalized ? widget.visitor.status! : 'Pending',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.orange,
                        ),
                      ),
                      items: isStatusFinalized
                          ? null
                          : dropdownOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              );
                            }).toList(),
                      onChanged: isStatusFinalized
                          ? null
                          : (newValue) async {
                              if (newValue != null) {
                                final comment = await _showCommentDialog();
                                await _updateVisitorStatus(newValue, comment);
                                widget.onStatusUpdated();
                              }
                            },
                    ),
                  ),
                ],
              ),
              if (isExpanded)
                Padding(
                  padding: EdgeInsets.only(top: screenWidth * 0.02),
                  child: Text(
                    'Purpose: ${widget.visitor.purposeOfVisit ?? 'N/A'}',
                    style: TextStyle(fontSize: screenWidth * 0.035),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.02),
                child: Text(
                  'Purpose: ${widget.visitor.purposeOfVisit ?? 'N/A'}',
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.02),
                child: Text(
                  'Purpose: ${widget.visitor.purposeOfVisit ?? 'N/A'}',
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.02),
                child: Text(
                  'Purpose: ${widget.visitor.purposeOfVisit ?? 'N/A'}',
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _showCommentDialog() async {
    final TextEditingController commentController = TextEditingController();

    return await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Comment (Optional)'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Enter your comment here (optional)',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Skip'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(commentController.text),
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateVisitorStatus(String status, String? comment) async {
    final url =
        'https://stagging.intouchsoftwaresolution.com/api/visitor-status/${widget.visitor.id}';

    final body = json.encode({
      'status': status,
      'comment_message': comment ?? '',
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated successfully')),
        );
      } else {
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
