import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/appbar.dart';
import 'package:society_app/pages/gatekeeper_dashboard/edit_profile.dart';
import 'package:society_app/res/component/guard/reusable_row.dart';
import 'package:society_app/res/component/round_button.dart';
import 'package:go_router/go_router.dart';
import 'package:society_app/view_model/guard/features.dart';
import 'package:society_app/view_model/user_session.dart';

class MoreSection extends StatefulWidget {
  const MoreSection({super.key});

  @override
  State<MoreSection> createState() => MoreSectionState();
}

class MoreSectionState extends State<MoreSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GuardFeatures>(context, listen: false).getUserDetailsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserSession>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final userDetails = Provider.of<GuardFeatures>(context).userDetails;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'More'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                userDetails?.data?.user?.name ?? 'No Name',
                                style: TextStyle(fontSize: 22),
                              ),
                              SizedBox(
                                height: screenWidth * 0.01,
                              ),
                              Text(userDetails?.data?.userDetail?.phoneNumber ??
                                  'Add Phone Number'),
                              SizedBox(
                                height: screenWidth * 0.01,
                              ),
                              Text(userDetails?.data?.user?.email ??
                                  'Add Email'),
                            ],
                          ),
                        ],
                      ),

                      // want to add one more below it
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    IconTextRow(
                      imagePath: 'assets/img/more/directory.png',
                      text: 'Directory',
                      onPressed: () {
                        print('Directory tapped');
                      },
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    IconTextRow(
                      imagePath: 'assets/img/more/documents.png',
                      text: 'Documents  ',
                      onPressed: () {
                        print('Home tapped');
                      },
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    IconTextRow(
                      imagePath: 'assets/img/more/referandearn.png',
                      icon: Icons.home,
                      text: 'Refer And Earn',
                      onPressed: () {
                        print('Home tapped');
                      },
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    IconTextRow(
                      imagePath: 'assets/img/more/notification.png',
                      icon: Icons.home,
                      text: 'Notification Setting',
                      onPressed: () {
                        print('Home tapped');
                      },
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    IconTextRow(
                      imagePath: 'assets/img/more/customer_care.png',
                      icon: Icons.home,
                      text: 'Help and Support',
                      onPressed: () {
                        print('Home tapped');
                      },
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    IconTextRow(
                      imagePath: 'assets/img/more/user.png',
                      icon: Icons.home,
                      text: 'App Support',
                      onPressed: () {
                        print('Home tapped');
                      },
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    IconTextRow(
                      imagePath: 'assets/img/more/terms.png',
                      icon: Icons.home,
                      text: 'Terms & Privacy',
                      onPressed: () {
                        print('Home tapped');
                      },
                    ),
                    SizedBox(
                      height: screenWidth * 0.04,
                    ),
                    RoundButton(
                      title: 'Logout',
                      onPressed: () async {
                        await userPreference.signOut().then((value) {
                          context.go('/login');
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
