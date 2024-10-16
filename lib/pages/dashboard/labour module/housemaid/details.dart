import 'package:flutter/material.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/constant/pallete.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Pallete.mainDashColor,
        appBar: CustomAppBar(title: 'Housemaid Details'),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: height * 0.4,
              color: Colors.black,
              child: LayoutBuilder(
                  builder: (context, constraints) => Stack(
                        children: [Container()],
                      )),
            ),
          ],
        ));
  }
}
