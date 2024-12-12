import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/pages/user_dashboard/modules/amenity_booking/available/available_amenities.dart';
import 'package:society_app/pages/user_dashboard/modules/amenity_booking/booking/book_amenities.dart';

class AmenityPage extends StatefulWidget {
  const AmenityPage({super.key});

  @override
  State<AmenityPage> createState() => _AmenityPageState();
}

class _AmenityPageState extends State<AmenityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Amenity Booking'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AvailableAmenitiesPage()));
              },
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                          'assets/img/dashboard/Amenity_booking/am.png'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Today Available Amenity',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Book amenities that are ',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'available today',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_right,
                        size: 40,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookAmenitiesPage()));
              },
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                          'assets/img/dashboard/Amenity_booking/am.png'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Book Amenities',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Book amenities that are ',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'upcoming dates',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_right,
                        size: 40,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
