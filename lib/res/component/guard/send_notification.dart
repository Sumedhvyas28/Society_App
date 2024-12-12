import 'package:flutter/material.dart';
import 'package:society_app/constant/pallete.dart';

class SendNotificationButton extends StatelessWidget {
  const SendNotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.mainBtnClr,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.15, vertical: 16),
          ),
          child: Text(
            'Send Notification',
            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
