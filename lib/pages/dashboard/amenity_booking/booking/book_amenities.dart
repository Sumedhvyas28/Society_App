import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/amenity_booking/book_amenities_data.dart';

class BookAmenitiesPage extends StatefulWidget {
  const BookAmenitiesPage({super.key});

  @override
  State<BookAmenitiesPage> createState() => _BookAmenitiesPageState();
}

class _BookAmenitiesPageState extends State<BookAmenitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Shop Module'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
              children: List.generate(bookAmenitiesItems.length, (index) {
            return _buildCard(context, index, bookAmenitiesItems[index]);
          })),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, index, dynamic item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => bookAmenitiesItems[index]['page']));
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
                child: Text(
                  item['title'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
