import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/notification_services.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_notification/guard_notification.dart';
import 'package:society_app/res/component/round_button.dart';
import 'package:society_app/view_model/guard/guard_prop.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:go_router/go_router.dart';

import '../../models/guard/visitor_details/visitor_details.dart';

class GuardNoitificationIconPage extends StatefulWidget {
  const GuardNoitificationIconPage({super.key});

  @override
  State<GuardNoitificationIconPage> createState() =>
      _GuardNoitificationIconPageState();
}

class _GuardNoitificationIconPageState
    extends State<GuardNoitificationIconPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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

    return Scaffold(
      appBar: CustomAppBar(title: 'Notifications'),
      backgroundColor: Pallete.mainDashColor,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.01),
        child: Column(
          children: [
            // Searchable text field

            Expanded(
              child: Consumer<GuardProp>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return Center(
                      child: Text(
                        'Fetching Notifications...',
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
                        'No new Notifications.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    );
                  }

                  // Filter visitors based on the search query
                  final filteredVisitors =
                      viewModel.visitorDetails.where((visitor) {
                    final nameMatch = visitor.visitorName
                            ?.toLowerCase()
                            .contains(_searchQuery) ??
                        false;
                    final statusMatch =
                        visitor.status?.toLowerCase().contains(_searchQuery) ??
                            false;
                    return nameMatch || statusMatch;
                  }).toList();

                  if (filteredVisitors.isEmpty) {
                    return Center(
                      child: Text(
                        'No new Notifications.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    );
                  }

                  // Limit the list to only the latest 5 notifications
                  final limitedVisitors = filteredVisitors.take(5).toList();

                  return ListView.builder(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    itemCount: limitedVisitors.length,
                    itemBuilder: (context, index) {
                      final visitor = limitedVisitors[index];
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
  final Data visitor;

  const ExpandableVisitorCard({Key? key, required this.visitor})
      : super(key: key);

  @override
  State<ExpandableVisitorCard> createState() => _ExpandableVisitorCardState();
}

class _ExpandableVisitorCardState extends State<ExpandableVisitorCard> {
  bool isExpanded = false;

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
          padding: EdgeInsets.all(screenWidth * 0.01),
          child: Row(
            children: [
              CircleAvatar(
                  radius: screenWidth * 0.1,
                  backgroundImage: AssetImage(
                    'assets/img/gs/userg.png',
                  )),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Column(
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
                          widget.visitor.commentMessage ?? 'N/A',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuardNotificationPage()));
                  },
                  child: Icon(Icons.arrow_right))
            ],
          ),
        ),
      ),
    );
  }
}
