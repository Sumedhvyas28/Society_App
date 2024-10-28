import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_notification/notifi_model.dart';

class GuardNotificationPage extends StatefulWidget {
  const GuardNotificationPage({super.key});

  @override
  State<GuardNotificationPage> createState() => _GuardNotificationPageState();
}

class _GuardNotificationPageState extends State<GuardNotificationPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredData = guardNotiData;

  @override
  void initState() {
    super.initState();
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
      _filteredData = guardNotiData
          .where((item) =>
              item['title']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()) ||
              item['content']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Guard Notification'),
      backgroundColor: Pallete.mainDashColor,
      body: SingleChildScrollView(
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
                    hintText: 'Search notifications...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // List of notifications
              ...List.generate(_filteredData.length, (index) {
                return _buildCard(context, index, _filteredData[index]);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, index, dynamic item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => item['page']));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(
                item['img'],
                width: 60,
                height: 60,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item['title'],
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
                          '08-07-2024',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.home,
                            size: 15, color: Pallete.mainDashColor),
                        Text(
                          'A-1023',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuardNotificationPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    elevation: 2,
                    backgroundColor: item['color'],
                  ),
                  child: Text(
                    item['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
