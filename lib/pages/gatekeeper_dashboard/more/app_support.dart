import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

class AppSupport extends StatefulWidget {
  const AppSupport({super.key});

  @override
  State<AppSupport> createState() => _AppSupportState();
}

class _AppSupportState extends State<AppSupport>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'App Support'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                // color: Colors. hite,
                child: Column(
                  children: [
                    // Tab buttons
                    Card(
                      color: Colors.white,
                      child: TabBar(
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        controller: _tabController,
                        indicatorColor: Colors.green,
                        dividerColor: Colors.grey,
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(text: 'Open Issues'),
                          Tab(text: 'Resolved Issues'),
                        ],
                      ),
                    ),
                    // Tab content
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Content for Tab 1
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: const Text(
                                                'New',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text(
                                              '#277293',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          'Replies',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                            'Users cannot submit the referral form ; Clicking the "Submit" button'),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today),
                                            const SizedBox(width: 4.0),
                                            Text('04-08-2024'),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://example.com/avatar.jpg'), // Replace with actual image URL
                                              radius: 20.0,
                                            ),
                                            const SizedBox(width: 8.0),
                                            Text('User 1'),
                                            const SizedBox(width: 16.0),
                                            const Icon(
                                                Icons.chat_bubble_outline),
                                            const SizedBox(width: 4.0),
                                            Text('0 Replies'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            itemCount: 6, // Number of small cards
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0), // Add spacing between cards
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        16.0), // Padding inside the card
                                    child: Row(
                                      children: [
                                        Icon(Icons.search_rounded),
                                        Text(
                                          'Issue Name ${index + 1}',
                                          style: TextStyle(fontSize: 16),
                                          // textAlign: TextAlign.center,
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Pallete.mainBtnClr,
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              'View Details',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
