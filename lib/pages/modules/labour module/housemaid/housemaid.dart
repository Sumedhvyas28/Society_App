import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/dummy/labour/housemaid.dart';
import 'package:society_app/pages/modules/labour%20module/housemaid/details.dart';

class HousemaidPage extends StatefulWidget {
  const HousemaidPage({super.key});

  @override
  State<HousemaidPage> createState() => _HousemaidPageState();
}

class _HousemaidPageState extends State<HousemaidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Labour Module'),
      backgroundColor: Pallete.mainDashColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(9),
          child: Column(
              children: List.generate(housemaidData.length, (index) {
            return _buildCard(context, index, housemaidData[index]);
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
                builder: (context) => housemaidData[index]['page']));
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
                        Image.asset(
                          'assets/img/dashboard/labour/star.png',
                          height: 9,
                        ),
                        Image.asset(
                          'assets/img/dashboard/labour/star.png',
                          height: 9,
                        ),
                        Image.asset(
                          'assets/img/dashboard/labour/star.png',
                          height: 9,
                        ),
                        Image.asset(
                          'assets/img/dashboard/labour/star.png',
                          height: 9,
                        ),
                        Image.asset(
                          'assets/img/dashboard/labour/star.png',
                          height: 9,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DetailsPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    elevation: 2,
                    backgroundColor: Pallete.mainBtnClr,
                  ),
                  child: Text(
                    'View Details',
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
