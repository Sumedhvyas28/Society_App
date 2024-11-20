import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/view_model/user_session.dart';
import 'package:society_app/view/login_page.dart';
import 'package:society_app/res/component/round_button.dart';

class MoreSection extends StatefulWidget {
  const MoreSection({super.key});

  @override
  State<MoreSection> createState() => MoreSectionState();
}

class MoreSectionState extends State<MoreSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    print('lqofqflqlflq');
    return Scaffold(
        appBar: CustomAppBar(title: 'more'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.asset("assets/img/gs/userg.png"),
                        SizedBox(
                          width: screenWidth * 0.04,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sumedh Vyas',
                              style: TextStyle(fontSize: 22),
                            ),
                            Text('A-103 Aparetment name '),
                            Text('Male  10/12/2002'),
                            Text('Cricket'),
                            Text('hello'),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
