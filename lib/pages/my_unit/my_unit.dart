import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/res/component/guard/reusable_row.dart';

class MyUnitPage extends StatefulWidget {
  const MyUnitPage({super.key});

  @override
  State<MyUnitPage> createState() => _MyUnitPageState();
}

class _MyUnitPageState extends State<MyUnitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'My Unit'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Circular rectangular container with a cleaner layout
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconTextRow(
                        imagePath: 'assets/img/gs/userg.png',
                        text: 'Guard 2',
                        onPressed: () {
                          print('Directory tapped');
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'A-102',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.car_rental, size: 40),
                      Text('Total Vehicles:', style: TextStyle(fontSize: 16)),
                      Text('00',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.group, size: 40),
                      Text('Total Members:', style: TextStyle(fontSize: 16)),
                      Text('03',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Dues',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    _buildDueCard(
                      dueDate: 'Due Date: 02-08-2024',
                      amount: '₹ 5,999.00/-',
                    ),
                    SizedBox(height: 16),
                    _buildDueCard(
                      dueDate: 'Due Date: 02-08-2024',
                      amount: '₹ 5,999.00/-',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDueCard({required String dueDate, required String amount}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dueDate, style: TextStyle(fontSize: 14)),
          SizedBox(height: 8),
          Text(amount,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.history),
                  Text('History'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.camera_alt),
                  Text('Advance/Deposit'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
