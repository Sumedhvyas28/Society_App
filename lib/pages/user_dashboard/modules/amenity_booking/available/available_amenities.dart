import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/dummy/amenity_booking/available_amentity_data.dart';

class AvailableAmenitiesPage extends StatefulWidget {
  const AvailableAmenitiesPage({super.key});

  @override
  State<AvailableAmenitiesPage> createState() => _AvailableAmenitiesPageState();
}

class _AvailableAmenitiesPageState extends State<AvailableAmenitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      appBar: CustomAppBar(title: 'Shop Module'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
              children: List.generate(availableAmenitiesItems.length, (index) {
            return _buildCard(context, index, availableAmenitiesItems[index]);
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
                builder: (context) => availableAmenitiesItems[index]['page']));
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
