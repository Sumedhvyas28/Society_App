import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/message/get_message.dart';
import 'package:society_app/pages/gatekeeper_dashboard/all_messages/chat_page.dart';
import 'package:society_app/repository/message.dart';

class AllMessagePage extends StatefulWidget {
  const AllMessagePage({super.key});

  @override
  State<AllMessagePage> createState() => _AllMessagePageState();
}

class _AllMessagePageState extends State<AllMessagePage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<GuardMessages>> _guardMessages;

  @override
  void initState() {
    super.initState();
    _guardMessages = GuardMessageRepo().fetchGuardMessages();
    _searchController.addListener(_filterData);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterData);
    _searchController.dispose();
    super.dispose();
  }

  void _filterData() {
    setState(() {
      // Here, we'll filter based on the message text if required
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'All Messages'),
      backgroundColor: Pallete.mainDashColor,
      body: FutureBuilder<List<GuardMessages>>(
        future: _guardMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('No New Messages'));
            // return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No messages available'));
          } else {
            List<GuardMessages> messages = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search messages...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...messages.map((message) => _buildCard(context, message)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, GuardMessages message) {
    return InkWell(
      onTap: () {
        // Navigate to ChatPage or any other relevant page
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatPage()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Placeholder image for now, replace with actual image if needed
              Image.asset(
                'assets/images/placeholder_image.png',
                width: 60,
                height: 60,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      message.message ?? 'No message',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month,
                            size: 15, color: Pallete.mainDashColor),
                        Text(
                          message.date ?? 'Unknown Date',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.home,
                            size: 15, color: Pallete.mainDashColor),
                        Text(
                          message.category ?? 'No category',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    elevation: 2,
                    backgroundColor: Pallete.mainDashColor,
                  ),
                  child: Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
