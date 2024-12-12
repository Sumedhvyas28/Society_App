import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/models/guard/note/noteDetails.dart';
import 'package:society_app/view_model/guard/notestatus.dart';

import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:http/http.dart' as http;

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to delay fetching until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);
      noteViewModel.fetchNotes();
    });
  }

  void _refreshVisitorList() {
    Provider.of<NoteViewModel>(context, listen: false).fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _searchController = TextEditingController();
    String _searchQuery = '';

    return Scaffold(
      appBar: CustomAppBar(title: 'Notes'),
      backgroundColor: Pallete.mainDashColor,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          children: [
            Expanded(
              child: Consumer<NoteViewModel>(
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

                  if (viewModel.notes.isEmpty) {
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
                  final filteredVisitors = viewModel.notes
                      .where((visitor) =>
                          (visitor.name?.toLowerCase().contains(_searchQuery) ??
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
                          Note: visitor,
                          onStatusUpdated: _refreshVisitorList,
                          visitor: null,
                        );
                      });
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
  final Data Note;
  final VoidCallback onStatusUpdated;

  const ExpandableVisitorCard({
    Key? key,
    required this.Note,
    required this.onStatusUpdated,
    required visitor,
  }) : super(key: key);

  @override
  State<ExpandableVisitorCard> createState() => _ExpandableVisitorCardState();
}

class _ExpandableVisitorCardState extends State<ExpandableVisitorCard> {
  bool isExpanded = false;

  bool get isStatusFinalized => widget.Note.status != 'Pending';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.Note.name ?? 'Unknown Visitor',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Text(
                        'Status: ${widget.Note.status}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          color: widget.Note.status == 'Approved'
                              ? Colors.green
                              : widget.Note.status == 'Rejected'
                                  ? Colors.red
                                  : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (widget.Note.status == 'Pending')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final comment = await _showCommentDialog();
                            await _updateVisitorStatus('Approved', comment);
                            widget.onStatusUpdated();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            'Approve',
                            style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            final comment = await _showCommentDialog();
                            await _updateVisitorStatus('Rejected', comment);
                            widget.onStatusUpdated();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.red,
                          ),
                          child: Text(
                            'Reject',
                            style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              if (isExpanded)
                Padding(
                  padding: EdgeInsets.only(top: screenWidth * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Descritpion: ${widget.Note.description ?? 'N/A'}',
                              style: TextStyle(fontSize: screenWidth * 0.025),
                            ),
                            Text(
                              'Time: ${widget.Note.time ?? 'N/A'}',
                              style: TextStyle(fontSize: screenWidth * 0.025),
                            ),
                            SizedBox(height: screenWidth * 0.02),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(width: screenWidth * 0.02),
                      if (widget.Note.image != null &&
                          widget.Note.image!.isNotEmpty)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centers the content vertically
                            crossAxisAlignment: CrossAxisAlignment
                                .center, // Centers the content horizontally
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(widget.Note.image);
                                  // Open a dialog to show the image in full screen
                                  _showImageDialog(context, widget.Note.image!);
                                },
                                child: widget.Note.image!.startsWith('http')
                                    ? Image.network(
                                        widget.Note.image!,
                                        fit: BoxFit.cover,
                                        height: screenWidth * 0.3,
                                        width: screenWidth * 0.3,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.broken_image,
                                            size: screenWidth * 0.3,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        widget.Note
                                            .image!, // Use Image.asset if it's a local asset
                                        fit: BoxFit.cover,
                                        height: screenWidth * 0.3,
                                        width: screenWidth * 0.3,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.broken_image,
                                            size: screenWidth * 0.3,
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        ),
                    ],
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
        'https://www.stagging.intouchsoftwaresolution.com/api/get-note-status/${widget.Note.id}';

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

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              // Close the dialog when tapping outside the image
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.black,
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit
                      .contain, // Keep the aspect ratio and zoom the image
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Show the broken image icon if image loading fails
                    return Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
